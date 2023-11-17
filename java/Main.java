import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

public class Main {

    static Stack stack = new Stack<List<Integer>>();
   

    private static final int entropy = 10;
    private static final int max_digit = 10;

    private static void initCh(Stack<List<Integer>> stack) {
        for (int i = 1; i <= entropy; i++) {
            List<Integer> e = new ArrayList<>();
            e.add(i);
            stack.push(e);
        }
    }

    private static boolean isSolution(List<Integer> item, List<Integer> solution) {
        if (item.size() != solution.size()) {
            return false;
        }
        for (int i = 0; i < item.size(); i++) {
            if (!item.get(i).equals(solution.get(i))) {
                return false;
            }
        }
        return true;
    }

    private static long genCh(Stack<List<Integer>> stack, List<Integer> parentItems, long stat) {
        if (parentItems.size() >= max_digit) {
            return stat;
        }

        for (int i = 1; i <= entropy; i++) {
            List<Integer> ch = new ArrayList<>(parentItems);
            ch.add(0, i);

            // System.out.printf("children: %s\n", ch);
            stack.push(ch);
        }
        // System.out.printf("stack %s \n", stack);

        return stat + entropy;
    }

    private static void solve(Stack<List<Integer>> stack, List<Integer> solution, long stat) {
        while (true) {
            if (stack.isEmpty()) {
                System.out.printf("Q IS EMPTY!, QUITTING!, count: %d\n", stat);
                return;
            }

            List<Integer> item = stack.pop();
            // System.out.printf("Solve: %s\n", item);

            if (isSolution(item, solution)) {
                System.out.printf("FOUND A SOLUTION %s, count: %d\n", item, stat);
                return;
            }

            stat = genCh(stack, item, stat);
        }
    }

    public static void main(String[] args) {
        for (int i = 0; i < 10; i++) {
            long start = System.nanoTime();
            List<Integer> solution = List.of(7, 7, 7, 7, 7, 7, 7, 5, 10);
            stack = new Stack<List<Integer>>();
            initCh(stack);
            System.out.printf("init stack %s \n", stack);

            solve(stack, solution, stack.size());
            long end = System.nanoTime();

            // Long l = new Long((end - start) / 1000);
            double duration = (double)((end - start) / 1000); // Convert to microseconds
            duration /= 1000.0; // Convert to milliseconds
            duration /= 1000.0; // Convert to seconds
            System.out.printf("time: %fs\n", duration);
        }
    }
}
