public class Env {
    public static void main(String[] args) {
        System.out.println("USER: " + System.getenv("USER"));
        System.out.println("UNA_VARIABLE: " + System.getenv("UNA_VARIABLE"));
        System.out.println("OTRA_VARIABLE: " + System.getenv("OTRA_VARIABLE"));
    }
}
