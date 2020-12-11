import strutils
import sequtils
import tables
import sugar
import threadpool
import locks

proc parseContent(s: string): (int, string) =
    let tokens = s.split(" ")
    let num = tokens[0]
    let name = tokens[1] & " " & tokens[2]
    return (parseInt(num), name)

proc parseContents(s: string): seq[(int, string)] =
    if s == "no other bags.":
        return @[]
    let contents = s.replace(".", "").split(",")
    result = @[]
    for content in contents:
        let c = parseContent(strip(content))
        result.add(c)
    
    
proc parseLine(s: string): (string, seq[(int, string)]) =
    let split = s.split(" bags contain ")
    let name = split[0]
    let contents = split[1]
    result = (name, parseContents(contents))

proc parseFile(s: string): Table[string, seq[(int, string)]] =
    result = initTable[string, seq[(int, string)]]()
    let lines = s.split("\n")
    for line in lines:
        let rule = parseLine(line)
        result[rule[0]] = rule[1]

# A little inefficient with a runtime of 1:40 minutes... but it works :D
proc canContain(rules: Table[string, seq[(int, string)]], containingBag: string, containedBag: string): bool =
    return rules[containingBag].any((t) => t[1] == containedBag) or rules[containingBag].any((t) => canContain(rules, t[1], containedBag))

var cache = initTable[string, bool]()
var cacheLock: Lock

# The cache helped, but it's still a little slow... Guess I'm going to parallelize then :D
proc canContain2(rules: Table[string, seq[(int, string)]], containingBag: string, containedBag: string): bool =
    {.cast(gcsafe).}: # threads must be gcsafe, but we are accessing the global cache
        cacheLock.acquire()
        if containingBag in cache:
            cacheLock.release()
            return true
        cacheLock.release()
        let inContainedBags = rules[containingBag].any((t) => t[1] == containedBag)
        if inContainedBags:
            cacheLock.acquire()
            cache[containingBag] = true
            cacheLock.release()
            return true
        let inRecursiveContainedBags = rules[containingBag].any((t) => canContain2(rules, t[1], containedBag))
        if inRecursiveContainedBags:
            cacheLock.acquire()
            cache[containingBag] = true
            cacheLock.release()
            return true
        return false

proc countContained(rules: Table[string, seq[(int, string)]], bag: string): int =
    return rules[bag].map((t) => t[0] + t[0] * countContained(rules, t[1])).foldl(a + b, 0)

let file = readFile("input.txt")
let rules = parseFile(file)
let myBag = "shiny gold"

echo "Solution 2: "
echo countContained(rules, myBag)

echo "Solution 1 (may take a while): "
var counter = 0
var responses = newSeq[FlowVar[bool]](rules.len())
initLock(cacheLock)
for bag, bags in rules.pairs:
    responses[counter] = spawn canContain2(rules, bag, myBag)
    counter += 1
deinitLock(cacheLock)
echo responses.map((x) => ^x).filter((x) => x).len()