## typecheck: ensuring that the types of objects is as expected

const typecheck_enabled = parse(Bool, @load_preference("typecheck", "false"))


## memcheck: keeping track when objects are valid

const memcheck_enabled = parse(Bool, @load_preference("memcheck", "false"))

const tracked_objects = Dict{Any,Any}()

function mark_alloc(obj::Any)
    @static if memcheck_enabled
        io = Core.stdout
        new_alloc_bt = backtrace()[2:end]

        if haskey(tracked_objects, obj)
            old_alloc_bt, dispose_bt = tracked_objects[obj]
            if dispose_bt == nothing
                print("\nWARNING: An instance of $(typeof(obj)) was not properly disposed of, and a new allocation will overwrite it.")
                print("\nThe original allocation was at:")
                Base.show_backtrace(io, old_alloc_bt)
                print("\nThe new allocation is at:")
                Base.show_backtrace(io, new_alloc_bt)
                println(io)
            end
        end

        tracked_objects[obj] = (new_alloc_bt, nothing)
    end
    return obj
end

function mark_use(obj::Any)
    @static if memcheck_enabled
        io = Core.stdout

        if !haskey(tracked_objects, obj)
            # we have to ignore unknown objects, as they may originate externally.
            # for example, a Julia-created Type we call `context` on.
            return obj
        end

        alloc_bt, dispose_bt = tracked_objects[obj]
        if dispose_bt !== nothing
            print("\nWARNING: An instance of $(typeof(obj)) is being used after it was disposed.")
            print("\nThe object was allocated at:")
            Base.show_backtrace(io, alloc_bt)
            print("\nThe object was disposed at:")
            Base.show_backtrace(io, dispose_bt)
            print("\nThe object is being used at:")
            Base.show_backtrace(io, backtrace()[2:end])
            println(io)
        end
    end
    return obj
end

function mark_dispose(obj)
    @static if memcheck_enabled
        io = Core.stdout
        new_dispose_bt = backtrace()[2:end]

        if !haskey(tracked_objects, obj)
            print(io, "\nWARNING: An unknown instance of $(typeof(obj)) is being disposed of.")
            Base.show_backtrace(io, new_dispose_bt)
            return
        end

        alloc_bt, old_dispose_bt = tracked_objects[obj]
        if old_dispose_bt !== nothing
            print("\nWARNING: An instance of $(typeof(obj)) is being disposed twice.")
            print("\nThe object was allocated at:")
            Base.show_backtrace(io, alloc_bt)
            print("\nThe object was already disposed at:")
            Base.show_backtrace(io, old_dispose_bt)
            print("\nThe object is being disposed again at:")
            Base.show_backtrace(io, new_dispose_bt)
            println(io)
        end

        tracked_objects[obj] = (alloc_bt, new_dispose_bt)
    end
    return
end

# helper for single-line disposal without a use-after-free warning
function mark_dispose(f, obj)
    ret = f(obj)
    mark_dispose(obj)
    return ret
end

function report_leaks(code=0)
    # if we errored, we can't trust the memory state
    if code != 0
        return
    end

    @static if memcheck_enabled
        io = Core.stdout
        for (obj, (alloc_bt, dispose_bt)) in tracked_objects
            if dispose_bt === nothing
                print(io, "\nWARNING: An instance of $(typeof(obj)) was not properly disposed of.")
                print("\nThe object was allocated at:")
                Base.show_backtrace(io, alloc_bt)
                println(io)
            end
        end
    end
end
