## typecheck: ensuring that the types of objects is as expected

const typecheck_enabled = parse(Bool, @load_preference("typecheck", "false"))


## memcheck: keeping track of allocations and disposals

const memcheck_enabled = parse(Bool, @load_preference("memcheck", "false"))

const tracked_objects = Dict{Any,Any}()

function mark_alloc(obj::Any)
    @static memcheck_enabled || return obj
    tracked_objects[obj] = backtrace()[3:end]
    return obj
end

function mark_dispose(obj)
    @static memcheck_enabled || return obj
    delete!(tracked_objects, obj)
    return obj
end

function check_memory(code)
    @static memcheck_enabled || return
    if code != 0
        # if we errorred, we don't care about leaks
        return
    end

    io = Core.stdout
    for (obj, bt) in tracked_objects
        print(io, "WARNING: An instance of $(typeof(obj)) was not properly disposed of.")
        Base.show_backtrace(io, bt)
        println(io)
    end
end
