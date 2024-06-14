function leakcheck_enabled()
    parse(Bool, @load_preference("leakcheck", "false"))
end

const tracked_objects = Dict{Any,Any}()

function mark_alloc(obj::Any)
    @static leakcheck_enabled() || return
    tracked_objects[obj] = backtrace()[3:end]
end

function mark_dispose(obj)
    @static leakcheck_enabled() || return
    delete!(tracked_objects, obj)
end

function check_leaks(code)
    @static leakcheck_enabled() || return
    if code != 0
        # if we errorred, we don't care about leaks
        return
    end

    io = Core.stdout
    for (obj, bt) in tracked_objects
        print(io, "WARNING: Object $obj was not properly disposed of.")
        Base.show_backtrace(io, bt)
        println(io)
    end
end
