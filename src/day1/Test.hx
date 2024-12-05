package day1;

class Test extends BaseTest
{
    public function new()
    {
        super();
        
        final left = [];
        final right = [];
        Data.getLists(left, right);
        
        left.sort((a, b)->a-b);
        right.sort((a, b)->a-b);
        
        var sumDiff = 0;
        var i = left.length;
        while (i-- > 0)
        {
            final diff = left[i] - right[i];
            sumDiff += diff < 0 ? -diff : diff;
        }
        
        trace('Total difference: $sumDiff');
        
        var score = 0;
        var i = 0;
        for (num in left)
        {
            // trace('num is $num');
            while (right[i] < num) {
                // trace('skipping ${right[i]}');
                i++;
            }
            
            var numFound = 0;
            while (right[i] == num)
            {
                numFound++;
                i++;
            }
            score += num * numFound;
            // trace('$num found $numFound times');
        }
        
        trace('similarity score: $score');
    }
}
