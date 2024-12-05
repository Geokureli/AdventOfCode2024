package day5;

import day5.Data;

class Test extends BaseTest
{
    public function new()
    {
        super();
        
        assert.equalTo(test1(Data.rulesEx1, Data.updatesEx1), 143);
        assert.equalTo(test2(Data.rulesEx1, Data.updatesEx1), 123);
        
        trace("test1 answer: " + test1(Data.rules, Data.updates));
        trace("test2 answer: " + test2(Data.rules, Data.updates));
    }
    
    function test1(rules:RulesList, lists:Array<UpdateList>, logResults = false)
    {
        var result = 0;
        for (list in lists)
        {
            switch (checkList(rules, list))
            {
                case Success:
                    result += list.getMiddle();
                    if (logResults) log.info('$list is valid');
                case Failure(reason):
                    if (logResults) log.info('$list is INVALID: $reason');
            }
        }
        
        return result;
    }
    
    function checkList(rules:RulesList, list:UpdateList):Result<String>
    {
        for (l in 0...list.length)
        {
            final left = list[l];
            for (r in l + 1...list.length)
            {
                final right = list[r];
                switch (rules.isInvalid(left, right))
                {
                    case Success:
                    case Failure(reason):
                        return Failure('$left,$right failed, $reason');
                }
            }
        }
        
        return Success;
    }
    
    function test2(rules:RulesList, lists:Array<UpdateList>, logResults = false)
    {
        var result = 0;
        for (list in lists)
        {
            switch (checkList(rules, list))
            {
                case Success:
                    // result += list.getMiddle();
                    if (logResults) log.info('$list is valid');
                case Failure(reason):
                    if (logResults) log.info('$list is INVALID: $reason');
                    final listCopy = list.copy();
                    sortList(listCopy, rules);
                    assert.equalTo(checkList(rules, listCopy), Success);
                    if (logResults) log.info('$list -> $listCopy');
                    result += listCopy.getMiddle();
            }
        }
        
        return result;
    }
    
    function sortList(list:UpdateList, rules:RulesList)
    {
        list.sort((left,right)->rules.isInvalid(left, right).match(Success) ? -1 : 1);
    }
}