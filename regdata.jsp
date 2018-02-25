<%@ page import="javax.mail.*,javax.mail.internet.*,javax.activation.*,java.util.*"%>
<%
  String fn=request.getParameter("t1");
  String ln=request.getParameter("t2");
 String em=request.getParameter("t3");
  String ps=request.getParameter("t4");
   String gn=request.getParameter("t5");
%>
<jsp:useBean id="u1" class="com.User"/>
<jsp:setProperty name="u1" property="fname" value="<%=fn%>"/>
<jsp:setProperty name="u1" property="lname" value="<%=ln%>"/>
<jsp:setProperty name="u1" property="gender" value="<%=gn%>"/>
<jsp:setProperty name="u1" property="email" value="<%=em%>"/>
<jsp:setProperty name="u1" property="password" value="<%=ps%>"/>

<%
	String s=com.UserReg.main(u1);
	if(s!=null)
	{
		out.println("<center>You are registered Successfully. transferring you to login page</center>");
		String st=sendMail(em,ps);
		out.println("<br>"+st+"");
		out.println("<a href='login.jsp'>Go to Login page</a></center>");
	}
	else
		out.println("Registration not done. something went wrong");
%>

<%!
    public String sendMail(String email,String password)
	{
		try
		{
		Properties p=new Properties();
		p.put("mail.smtp.host","smtp.gmail.com");
		p.put("mail.smtps.auth","true");
		
		Session session=Session.getDefaultInstance(p);

		MimeMessage msg=new MimeMessage(session);
		
		InternetAddress from=new InternetAddress("anasoftcool@gmail.com");
                InternetAddress to=new InternetAddress(email);
		msg.setFrom(from);
		msg.setRecipient(Message.RecipientType.TO,to);
		msg.setSubject("Welcome to Secure World");
		msg.setSentDate(new Date());

                Multipart body=new MimeMultipart();
		MimeBodyPart part=new MimeBodyPart();
		part.setText("Use your Email And Password to login");
		body.addBodyPart(part);
                
		MimeBodyPart part1=new MimeBodyPart();
		part1.setText("Your Email : "+email);
		body.addBodyPart(part1);
                
                MimeBodyPart part2=new MimeBodyPart();
		part2.setText("Your Password : "+password);
		body.addBodyPart(part2);

		msg.setContent(body);
		
		Transport t=session.getTransport("smtps");
		System.out.println("connecting to server...");
		t.connect("smtp.gmail.com","anasoftcool@gmail.com","9935221405");
		System.out.println("sending message pls wait...");
		t.sendMessage(msg,msg.getAllRecipients());
		return "Your Email and password sent to Your mail. Please check your mail.";
		}	
		catch(com.sun.mail.smtp.SMTPSendFailedException e)
		{
			return "smtps authentication failed check smtps property in the Properties.";
		}
		catch(javax.mail.MessagingException e)
		{
			return "internet not connected. or unknown host";
		}
		catch(Exception e)
		{
            return "Something Went Wrong.";
		}
  }

%>