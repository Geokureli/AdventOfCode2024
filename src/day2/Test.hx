package day2;

class Test extends BaseTest
{
    public function new()
    {
        super();
        
        var numSafe = 0;
        // for (report in Data.getTestReports())
        for (report in Data.getReports())
        {
            if (report.length < 2)
            {
                numSafe++;
                continue;
            }
            
            final increasing = report[1] > report[0];
            if (isSafe(report))
            {
                numSafe++;
                log.verbose('Safe report: $report');
            }
        }
        
        log('Safe reports: $numSafe');
    }
    
    function isSafe(report:Array<Int>, allowDampening = true)
    {
        final increasing = report[1] > report[0];
        
        for (i in 1...report.length)
        {
            final diff = increasing
                ? report[i] - report[i - 1]
                : report[i - 1] - report[i];
            
            log.verbose('diff[$i] = $diff');
            
            if (diff < 1 || diff > 3)
            {
                if (allowDampening)
                {
                    // dampen once
                    allowDampening = false;
                    if (isSafeDampened(report, i))
                    {
                        log.verbose('$report is safe without [$i]:${report[i]}');
                        return true;
                    }
                    
                    if (isSafeDampened(report, i - 1))
                    {
                        log.verbose('$report is safe without [$i]:${report[i - 1]}');
                        return true;
                    }
                    
                    if (isSafeDampened(report, 0))
                    {
                        log.verbose('$report is safe without [$0]:${report[0]}');
                        return true;
                    }
                    log.verbose('$report is not safe regardless');
                }
                
                return false;
            }
        }
        
        log.verbose('$report is safe');
        return true;
    }
    
    function isSafeDampened(report:Array<Int>, without:Int)
    {
        final copy = report.copy();
        copy.splice(without, 1);
        final result = isSafe(copy, false);
        // log.verbose('$report without [$without]:$copy is ${result ? "" : "not"} safe');
        return result;
    }
}