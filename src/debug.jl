## typecheck: ensuring that the types of objects is as expected

const typecheck_enabled = parse(Bool, @load_preference("typecheck", "false"))


## memcheck: keeping track of allocations and disposals

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

function mark_dispose(obj)
    @static if memcheck_enabled
        io = Core.stdout
        new_dispose_bt = backtrace()[2:end]

        if !haskey(tracked_objects, obj)
            print(io, "\nWARNING: An unknown instance of $(typeof(obj)) is being disposed of.")
            Base.show_backtrace(io, new_dispose_bt)
            return obj
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
    return obj
end

function report_leaks(code)
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
