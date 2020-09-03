import java.net.*;
import java.io.*;
import java.util.concurrent.ThreadFactory;

public class EchoServerVThread
{
    public static void main(String[] args) throws InterruptedException {
        ThreadFactory virtualThreadFactory = Thread.builder().virtual().factory();

        int cnt = 0;
        try {
            ServerSocket serverSocket = new ServerSocket(5566);
            while (true) {
                Socket clientSocket = serverSocket.accept();
                Thread thread = virtualThreadFactory.newThread(new Responder(++cnt, clientSocket));
                thread.start();
            }
        } catch (Exception e) {
            System.out.println(e.toString());
            System.exit(1);
        }
    }
}
