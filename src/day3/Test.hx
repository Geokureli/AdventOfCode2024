package day3;

class Test extends BaseTest
{
    public function new()
    {
        super(NONE);
        assert.equalTo(test1("mul(+3,4)mul(-3,5)"), 0);
        assert.equalTo(test2("mul(2,3)don't()mul(1,2)"), 6);
        assert.equalTo(test2("mul(1,2)do()mul(1,2)"), 4);
        assert.equalTo(test2("mul(2,1,hi)don't()"), 0);
        assert.equalTo(test2("mul(1,1)"), 1);
        assert.equalTo(test2_NL("mul(1,2)don't()mul(3,4)\nmul(5,6)do()mul(7,8)"), 2+56);
        log("test1 answer: " + test1(Data.program));
        log("test2 answer: " + test2(Data.program));
        log.info("2 answer (no new_line): " + test2_NL(Data.program));
    }
    
    function test1(program:String)
    {
        static final finder = ~/mul\((\d{1,3}),(\d{1,3})\)/;
        var sum = 0;
        var start = 0;
        while(finder.matchSub(program, start))
        {
            final pos = finder.matchedPos();
            final sub = program.substring(pos.pos, pos.len);
            final result = Std.parseInt(finder.matched(1)) * Std.parseInt(finder.matched(2));
            sum += result;
            // log.info('$sub = $result');
            start = pos.pos + pos.len;
        }
        return sum;
    }
    
    function test2_NL(program:String)
    {
        return test2(program.split("\n").join("|"));
    }
    
    function test2(program:String)
    {
        static final finder = ~/don't\(\).+?(do\(\)|$)/gs;
        final trimmed = finder.split(program).join("|");
        // log.verbose('trimmed: $trimmed');
        return test1(trimmed);
    }
}