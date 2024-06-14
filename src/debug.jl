## typecheck: ensuring that the types of objects is as expected

const typecheck_enabled = parse(Bool, @load_preference("typecheck", "false"))


## memcheck: keeping track of allocations and disposals

const memcheck_enabled = parse(Bool, @load_preference("memcheck", "false"))

const tracked_objects = Dict{Any,Any}()

function mark_alloc(obj::Any)
    @static if memcheck_enabled
        tracked_objects[obj] = backtrace()[2:end]
    end
    return obj
end

function mark_dispose(obj)
    @static if memcheck_enabled
        delete!(tracked_objects, obj)
    end
    return obj
end

function report_leaks(code)
    # if we errorred, we can't trust the memory state
    if code != 0
        return
    end

    @static if memcheck_enabled
        io = Core.stdout
        for (obj, bt) in tracked_objects
            print(io, "WARNING: An instance of $(typeof(obj)) was not properly disposed of.")
            Base.show_backtrace(io, bt)
            println(io)
        end
    end
end
