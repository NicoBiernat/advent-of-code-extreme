declare -a input

function task1() {
    declare -a visited
    length=${#input[@]}
    for ((i = 0; i < $length; i++)); do
        visited[$i]=false
    done
    pc=0
    acc=0
    while ! ${visited[$pc]}; do
        visited[$pc]=true
        line=(${input[pc]})
        op=${line[0]}
        val=${line[1]}
        case "$op" in
            nop) pc=$((pc + 1));;
            acc) acc=$((acc + val)) 
                pc=$((pc + 1));;
            jmp) pc=$((pc + val));;
        esac
    done
    echo $acc
}

function task2() {
    declare -a visited
    length=${#input[@]}
    pc=-1
    acc=-1
    terminated=false
    declare -a changedPC
    for ((i = 0; i < $length; i++)); do
        changedPC[$i]=false
    done
    while ! $terminated; do
        for ((i = 0; i < $length; i++)); do
            visited[$i]=false
        done
        pc=0
        acc=0
        changed=false
        while ! ${visited[$pc]}; do
            if (($pc >= $length-1)); then
                terminated=true
                break
            fi
            visited[$pc]=true
            line=(${input[pc]})
            op=${line[0]}
            val=${line[1]}

            case "$op" in
                nop)
                    if [ "${changed}" == "false" ] && [ "${changedPC[$pc]}" == "false" ]; then
                        changed=true
                        changedPC[$pc]=true
                        pc=$((pc + val)) # do jmp instead
                    else
                        pc=$((pc + 1))
                    fi
                ;;
                acc)
                    acc=$((acc + val)) 
                    pc=$((pc + 1))
                ;;
                jmp)
                    if [ "${changed}" == "false" ] && [ ${changedPC[$pc]} == "false" ]; then
                        changed=true
                        changedPC[$pc]=true
                        pc=$((pc + 1)) # do nop instead
                    else
                        pc=$((pc + val))
                    fi
                ;;
            esac
        done
    done
    echo $acc
}

i=0
while IFS= read -r line; do
    input[$i]=$line
    i=$((i + 1))
done < input.txt

t1="$(task1)"
echo "Solution 1: "$t1

t2="$(task2)"
echo "Solution 2: "$t2