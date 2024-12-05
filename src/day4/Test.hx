package day4;

import day4.Data;

class Test extends BaseTest
{
    static final example1
        = "ZZZZZZ\n"
        + "ZZZZZZ\n"
        + "ZZZZZZ\n"
        + "ZZZZZZ\n"
        + "ZZZZZZ\n"
        + "ZZZZZZ";
    static final result1
        = "......\n"
        + "......\n"
        + "......\n"
        + "......\n"
        + "......\n"
        + "......";
    static final example2
        = "ZZZZZZ\n"
        + "ZXZZZZ\n"
        + "ZZMZZZ\n"
        + "ZZZAZZ\n"
        + "ZZZZSZ\n"
        + "ZZZZZZ";
    static final result2
        = "......\n"
        + ".X....\n"
        + "..M...\n"
        + "...A..\n"
        + "....S.\n"
        + "......";
    static final example3
        = "MMMSXXMASM\n"
        + "MSAMXMSMSA\n"
        + "AMXSXMAAMM\n"
        + "MSAMASMSMX\n"
        + "XMASAMXAMM\n"
        + "XXAMMXXAMA\n"
        + "SMSMSASXSS\n"
        + "SAXAMASAAA\n"
        + "MAMMMXMMMM\n"
        + "MXMXAXMASX";
    static final result3
        = "....XXMAS.\n"
        + ".SAMXMS...\n"
        + "...S..A...\n"
        + "..A.A.MS.X\n"
        + "XMASAMX.MM\n"
        + "X.....XA.A\n"
        + "S.S.S.S.SS\n"
        + ".A.A.A.A.A\n"
        + "..M.M.M.MM\n"
        + ".X.X.XMASX";
    
    public function new()
    {
        super(INFO);
        
        final data1 = new String2d(example1);
        assert.equalTo(data1.columns, 6);
        assert.equalTo(data1.rows, 6);
        assert.equalTo(data1.length, 36);
        assert.equalTo(data1.getIndex(0, 0), 0);
        assert.equalTo(data1.getIndex(1, 1), 7);
        
        final oneRow = new String2d("XMAS");
        assert.equalTo(oneRow.rows, 1);
        assert.equalTo(oneRow.columns, 4);
        final oneCol = new String2d("X\nM\nA\nS");
        assert.equalTo(oneCol.columns, 1);
        assert.equalTo(oneCol.rows, 4);
        
        assert.equalTo(test1("XMAS"), 1);
        assert.equalTo(test1("SMAX"), 0);
        assert.equalTo(test1("SAMX"), 1);
        assert.equalTo(test1("X\nM\nA\nS"), 1);
        assert.equalTo(test1("S\nA\nM\nX"), 1);
        
        assert.equalTo(test1Replace(example1), result1);
        assert.equalTo(test1Replace(example2), result2);
        assert.equalTo(test1Replace(example3), result3);
        
        log("test1 answer: " + test1(Data.get()));
        log("test2 answer: " + test2(Data.get()));
    }
    
    function test1Replace(input:String, logInfo = false):String
    {
        final word = "XMAS";
        final replace = "....";
        final data = new String2d(input);
        final copy = data.copy();
        final result = data.copy();
        log.verbose('data:\n${data.data}');
        test1Helper(data, copy, word, replace);
        log.verbose('copy:\n${copy.data}');
        for (i in copy)
        {
            if (copy[i] != ".")
                result[i] = ".";
        }
        log.verbose('result:\n${result.data}');
        return result.data;
    }
    
    function test1(input:String, logInfo = false)
    {
        final puzzle = new String2d(input);
        return test1Helper(puzzle, puzzle.copy(), "XMAS", "....", logInfo);
    }
    
    function test1Helper(puzzle:String2d, copy:String2d, word:String, replace:String, logInfo = false)
    {
        final start = word.charAt(0);
        final end = word.substr(1);
        var sum = 0;
        final c = puzzle.columns;
        final r = puzzle.rows;
        
        function checkWordAndWriteToCopy(x:Int, y:Int, xD:Int, yD:Int):Int
        {
            if (puzzle.checkWord(x + xD, y + yD, xD, yD, end))
            {
                copy.writeWord(x, y, xD, yD, replace);
                return 1;
            }
            else if (logInfo)
            {
                final len = 4;
                if      (x + xD * len < 0) log.info('[$x,$y]@[$xD,$yD]->[${x + xD * len} < 0,y]');
                else if (x + xD * len > c) log.info('[$x,$y]@[$xD,$yD]->[${x + xD * len} > $c,y]');
                else if (y + yD * len < 0) log.info('[$x,$y]@[$xD,$yD]->[x,${x + yD * len} < 0]');
                else if (y + yD * len > r) log.info('[$x,$y]@[$xD,$yD]->[x,${y + yD * len} > $r]');
                else log.info('[$x,$y]@[$xD,$yD]=${puzzle.getWord(x, y, xD, yD, word.length)}');
            }
            
            return 0;
        }
        
        for (x in 0...puzzle.columns)
        {
            for (y in 0...puzzle.rows)
            {
                if (puzzle.get(x, y) == start)
                {
                    sum += checkWordAndWriteToCopy(x, y,  1,  0);
                    sum += checkWordAndWriteToCopy(x, y, -1,  0);
                    sum += checkWordAndWriteToCopy(x, y,  0, -1);
                    sum += checkWordAndWriteToCopy(x, y,  0,  1);
                    sum += checkWordAndWriteToCopy(x, y,  1,  1);
                    sum += checkWordAndWriteToCopy(x, y,  1, -1);
                    sum += checkWordAndWriteToCopy(x, y, -1,  1);
                    sum += checkWordAndWriteToCopy(x, y, -1, -1);
                }
            }
        }
        
        return sum;
    }
    
    function test2(data:String)
    {
        final puzzle = new String2d(data);
        function checkXmas(x, y)
        {
            inline function get(xD, yD) return puzzle.get(x + xD, y + yD);
            
            return switch (get(-1, -1) + get(-1, 1) + get(1, 1) + get(1, -1))
            {
                case "MMSS" | "MSSM" | "SSMM" | "SMMS":
                    true;
                default:
                    false;
            }
        }
        
        var sum = 0;
        for (x in 1...puzzle.columns - 1)
        {
            for (y in 1...puzzle.rows - 1)
            {
                if (puzzle.get(x, y) == "A" && checkXmas(x, y))
                    sum++;
            }
        }
        
        return sum;
    }
}