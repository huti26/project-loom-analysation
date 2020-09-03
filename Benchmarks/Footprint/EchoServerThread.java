import java.net.*;
import java.io.*;
import java.util.concurrent.ThreadFactory;

public class EchoServerThread
{
    public static void main(String[] args) throws InterruptedException {
        ThreadFactory kernelThreadFactory = Thread.builder().factory();

        int cnt = 0;
        try {
            ServerSocket serverSocket = new ServerSocket(5566);
            while (true) {
                Socket clientSocket = serverSocket.accept();
                Thread thread = kernelThreadFactory.newThread(new Responder(++cnt, clientSocket));
                thread.start();
            }
        } catch (Exception e) {
            System.out.println(e.toString());
            System.exit(1);
        }
    }
}