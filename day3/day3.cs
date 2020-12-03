using System;

namespace app
{
    class Program
    {
        static void Main(string[] args)
        {
            string text = System.IO.File.ReadAllText(@"input.txt");
            string[] lines = text.Split('\n');
            
            long trees1 = CountTrees(lines, 3, 1);
            Console.WriteLine("Solution 1: " + trees1);

            long[] trees = new long[5];
            trees[0]= CountTrees(lines, 1, 1);
            trees[1] = CountTrees(lines, 3, 1);
            trees[2] = CountTrees(lines, 5, 1);
            trees[3] = CountTrees(lines, 7, 1);
            trees[4] = CountTrees(lines, 1, 2);
            
            long product = 1;
            foreach (long treeCount in trees) {
                product *= treeCount;
            }
            Console.WriteLine("Solution 2: " + product);

        }

        static long CountTrees(string[] linesImmutable, int deltaX, int deltaY)
        {
            string[] lines = new string[linesImmutable.Length];
            Array.Copy(linesImmutable, 0, lines , 0, linesImmutable.Length);

            long count = 0;
            int x = 0;
            int y = 0;
            
            while (y < lines.Length) {
                while (x >= lines[y].Length) {
                    lines[y] = lines[y] + linesImmutable[y];
                }
                char c = lines[y][x];
                if (c == '#') {
                    count++;
                }
                x += deltaX;
                y += deltaY;
            }

            return count;
        }
    }
}
