<?php
$inputStr = file_get_contents("input.txt");
$input = explode("\n", $inputStr);

$output = array_map('getSeatNumber', $input);

$solution = max($output);
echo "Solution 1: " . $solution . "\n";

$solution2 = findFreeSeat($output);
echo "Solution 2: " . $solution2 . "\n";

function getSeatNumber($line) {
    $s1 = substr($line, 0, 7);
    $row = binaryPartition(substr($line, 0, 7), 'F', 'B', 0, 127);
    $s2 = substr($line, 7, 3);
    $col = binaryPartition(substr($line, 7, 3), 'L', 'R', 0,   7);
    return $row * 8 + $col;
}

function binaryPartition($line, $lower_char, $upper_char, $lower, $upper) {
    if ($line == "") {
        return $lower;
    }
    switch ($line[0]) {
        case $lower_char:
            $l = substr($line, 1, strlen($line) - 1);
            return binaryPartition($l, $lower_char, $upper_char, $lower, floor(($upper - $lower) / 2) + $lower);
        case $upper_char:
            $l = substr($line, 1, strlen($line) - 1);
            return binaryPartition($l, $lower_char, $upper_char, ceil(($upper - $lower) / 2) + $lower, $upper);
    }
}

function findFreeSeat($taken_seats) {
    sort($taken_seats);
    for ($i = 0; $i < count($taken_seats); $i++) {
        if ($taken_seats[$i] + 1 != $taken_seats[$i+1]) { 
            return $taken_seats[$i] + 1;
        }
    }
}
?>