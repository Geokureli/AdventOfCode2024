import haxe.PosInfos;
import Logger;

class BaseTest
{
    final log:Logger;
    final assert = new Assert();
    
    public function new(logLevel = LogLevel.NONE)
    {
        final id = Type.getClassName(Type.getClass(this)).split(".")[0];
        log = new Logger(id, logLevel);
        // log('Running $id');
    }
}

class Assert
{
    public function new() {}
    
    inline public function fail(msg:String) throw 'Assert fail: $msg';
    
    inline function backupMsg(msg:Null<String>, backup:String)
    {
        return msg != null ? msg : backup;
    }
    
    inline public function isTrue(condition:Bool, ?msg)
    {
        if (condition == false)
            fail(backupMsg(msg, "Expected true, got false"));
    }
    
    inline public function isFalse(condition:Bool, ?msg)
    {
        if (condition)
            fail(backupMsg(msg, "Expected false, got true"));
    }
    
    inline public function equalTo<T>(value:T, expected:T, ?msg)
    {
        isTrue(value == expected, backupMsg(msg, 'Expected $expected, got $value'));
    }
    
    inline public function notEqualTo<T>(value:T, unexpected:T, ?msg)
    {
        isTrue(value != unexpected, backupMsg(msg, 'Unexpected value $unexpected'));
    }
}