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
        
        log('test1 answer: $sumDiff');
        
        var score = 0;
        var i = 0;
        for (num in left)
        {
            // log('num is $num');
            while (right[i] < num) {
                // log('skipping ${right[i]}');
                i++;
            }
            
            var numFound = 0;
            while (right[i] == num)
            {
                numFound++;
                i++;
            }
            score += num * numFound;
            // log('$num found $numFound times');
        }
        
        log('test2 answer: $score');
    }
}
