import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class Responder implements Runnable
{
    private Socket socket;
    private int counter;

    public Responder(int counter, Socket socket)
    {
        this.counter = counter;
        this.socket = socket;
    }

    public void run()
    {
        try {
            // Get input and output streams to talk to the client
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            PrintWriter out = new PrintWriter(socket.getOutputStream());

            // Start sending our reply, using the HTTP 1.1 protocol
            out.print("HTTP/1.1 200 \r\n"); // Version & status code
            out.print("Content-Type: text/plain\r\n"); // The type of data
            out.print("Connection: close\r\n"); // Will close stream
            out.print("\r\n"); // End of headers

            // Echo request as answer
            String line;
            while ((line = in.readLine()) != null) {
                if (line.length() == 0)
                    break;
                out.print(line + "\r\n");
            }

            // close all
            out.close(); 
            in.close(); 
            socket.close(); 

        } catch (Exception e) {
            System.out.println(e.toString());
            System.exit(1);
        }
    }
}