import haxe.PosInfos;

@:forward
abstract Logger(LoggerRaw)
{
    public function new (id, level)
    {
        this = new LoggerRaw(id, level);
    }
    
    @:op(a())
    inline function callPos(msg:Dynamic, ?pos:PosInfos)
    {
        this.log(msg, pos);
    }
}

@:allow(Logger)
private class LoggerRaw
{
    public final id:String;
    public final level:LogLevel;
    
    public function new (id, level)
    {
        this.id = id;
        this.level = level;
    }
    
    inline function log(msg:Dynamic, ?pos:PosInfos)
    {
        haxe.Log.trace('$id: $msg', pos);
    }
    
    inline function logIf(level:LogLevel, msg:Dynamic, ?pos)
    {
        if (this.level >= level)
            log('$id: $msg', pos);
    }
    
    public function warn   (msg:Dynamic, ?pos) logIf(WARN, msg, pos);
    public function info   (msg:Dynamic, ?pos) logIf(INFO, msg, pos);
    public function verbose(msg:Dynamic, ?pos) logIf(VERBOSE, msg, pos);
}

enum abstract LogLevel(Int)
{
    var NONE = 0;
    var WARN = 1;
    var INFO = 2;
    var VERBOSE = 3;
    
    @:op(A > B)
    inline static function gt(a:LogLevel, b:LogLevel)
    {
        return a.toInt() > b.toInt();
    }
    
    @:op(A < B)
    inline static function lt(a:LogLevel, b:LogLevel)
    {
        return a.toInt() < b.toInt();
    }
    
    @:op(A >= B)
    inline static function gte(a:LogLevel, b:LogLevel)
    {
        return a.toInt() >= b.toInt();
    }
    
    @:op(A <= B)
    inline static function lte(a:LogLevel, b:LogLevel)
    {
        return a.toInt() <= b.toInt();
    }
    
    function toInt() return this;
}