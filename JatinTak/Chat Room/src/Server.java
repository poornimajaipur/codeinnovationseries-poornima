import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;


import javax.swing.JLabel;
import java.awt.Font;
import java.awt.Frame;
import java.awt.TextArea;
import java.awt.TextField;

import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.awt.event.ActionEvent;
import javax.swing.JScrollPane;

public class Server extends JFrame {

	private JPanel contentPane;
	private  JTextField textField;
	private static JTextArea textArea;
	static ServerSocket ss;
	static Socket sc;
	static DataInputStream dis;  
	static DataOutputStream dos;  

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Server frame = new Server();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
		
		String messagein= "";
		try
		{
			ss= new ServerSocket(4444);
			sc= ss.accept();
			dis= new DataInputStream(sc.getInputStream());
			dos= new DataOutputStream(sc.getOutputStream());
			
			while (!messagein.equals("bye"))
			{
				messagein= dis.readUTF();
				textArea.setText(textArea.getText().trim()+ "\n Client:"+ messagein);
			}
		}
		catch (Exception e1)
		{
		}
	}

	/**
	 * Create the frame.
	 */
	public Server() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 492, 463);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblServer = new JLabel("SERVER");
		lblServer.setFont(new Font("Times New Roman", Font.BOLD, 16));
		lblServer.setBounds(202, 10, 72, 31);
		contentPane.add(lblServer);
		
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(10, 51, 458, 203);
		contentPane.add(scrollPane);
		
		textArea = new JTextArea();
		scrollPane.setViewportView(textArea);
		textArea.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		
		textField = new JTextField();
		textField.setFont(new Font("Times New Roman", Font.PLAIN, 12));
		textField.setBounds(10, 323, 458, 36);
		contentPane.add(textField);
		textField.setColumns(10);
		
		JLabel lblTypeYourMessage = new JLabel("Type your message here:");
		lblTypeYourMessage.setFont(new Font("Times New Roman", Font.BOLD, 14));
		lblTypeYourMessage.setBounds(10, 286, 353, 27);
		contentPane.add(lblTypeYourMessage);
		
		JButton btnSend = new JButton("SEND");
		btnSend.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try
				{
					String messageout= "";
					messageout= textField.getText().trim();
					dos.writeUTF(messageout);
					textField.setText(null);
				}
				catch (Exception e1)
				{
				}
			}
		});
		btnSend.setFont(new Font("Times New Roman", Font.BOLD, 14));
		btnSend.setBounds(366, 375, 102, 31);
		contentPane.add(btnSend);
	}
}
