import java.applet.*;
import java.awt.*;
import java.awt.event.*;

public class Flower extends Applet implements ActionListener
{
	public int a=0,x=100,y=100;
	public void init()
	{
		button1 = new Button("LEFT");
		add(button1);
		
		button1.addActionListener(this);

		button2 = new Button("RIGHT");
		add(button2);
		
		button2.addActionListener(this);
		
		button3 = new Button("UP");
		add(button3);
		button3.addActionListener(this);

		button4 = new Button("DOWN");
		add(button4);
		
		button4.addActionListener(this);
	}
	

	public void actionPerformed(ActionEvent e) {
		if (e.getSource() == button1)
		{
			a=1;
			System.out.println("LEFT");
			repaint();
		}
		if (e.getSource() == button2)
		{
			a=2;
			System.out.println("RIGHT");
			repaint();
		}
		if (e.getSource() == button3)
		{
			a=3;
			System.out.println("UP");
			repaint();
		}
		if (e.getSource() == button4)
		{
			a=4;
			System.out.println("DOWN");
			repaint();
		}
	}
	
	public void paint(Graphics g) 
    {
		if(a==1)
		{
			x=x-10;
		}
		if(a==2)
		{
			x=x+10;
		}
		if(a==3)
		{
			y=y-10;
		}
		if(a==4)
		{
			y=y+10;
		}
        g.fillOval(x,y,40,40); 
        g.fillOval(x,y+40,40,40); 
		g.fillOval(x+40,y,40,40); 
        g.fillOval(x+40,y+40,40,40);
		g.setColor(Color.BLACK); 
		g.fillOval(x+20,y+20,40,40);
    }
	Button button1, button2,button3,button4;
}

/*
<APPLET code= "Flower.class" width="350" height="300">
</APPLET>
*/