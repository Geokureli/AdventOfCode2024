import haxe.PosInfos;

class Logger
{
    var level:LogLevel;
    
    public function new (level)
    {
        this.level = level;
    }
    
    inline function log(level:LogLevel, msg:Dynamic, ?pos)
    {
        if (this.level >= level)
            haxe.Log.trace(msg, pos);
    }
    
    public function warn   (msg:Dynamic, ?pos) log(WARN, msg, pos);
    public function info   (msg:Dynamic, ?pos) log(INFO, msg, pos);
    public function verbose(msg:Dynamic, ?pos) log(VERBOSE, msg, pos);
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