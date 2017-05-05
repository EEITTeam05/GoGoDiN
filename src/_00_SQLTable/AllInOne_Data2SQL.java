package _00_SQLTable;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;

import com.img.Io.ImagesIo;
import com.member.Model.MemberService;
import com.rest.Model.RestService;
import com.restPhoto.Model.RestPhotoService;

public class AllInOne_Data2SQL {

	public static final String UTF8_BOM = "\uFEFF";
	static Integer MemId;
	static String  MemAccount;
	static String  MemPswd ;
	static String  MemName ;
	static Integer Sex = 1;
	
	static String dateString;
	static SimpleDateFormat sdf;
	static long uday;
	static java.sql.Date Birthday;
	
	static String  Email;
	static String  MlineId;
	static String  MemTel;
	static String  MemAddr;
	static File imageFile;
	static InputStream is;
	static String fileName;
	static String Restbrief;
	static ImagesIo io;
	static byte[] data;
	
	
	static Integer RestId;
	static Integer ShopId;
	static String RestName;
	static String RestTel;
	static String Restaddr;
	static Integer Ein;
	
	static Time RestStart;
	static Time RestEnd;
	
	static Integer RestRate;
	static Integer RestNum;	
		
	static String[] food = {"" ,"God_Father", "devil", "redbeaf","wangping"};


	public static void main(String[] args) throws Exception {
		
		
		
/*		'||    ||' '||''''|  '||    ||' '||''|.   '||''''|  '||''|.   
 *		 |||  |||   ||  .     |||  |||   ||   ||   ||  .     ||   ||  
 *		 |'|..'||   ||''|     |'|..'||   ||'''|.   ||''|     ||''|'   
 *		 | '|' ||   ||        | '|' ||   ||    ||  ||        ||   |.  
 *		.|. | .||. .||.....| .|. | .||. .||...|'  .||.....| .||.  '|' 
 *
 **********************************************************************/	
		
		MemId = 1;
		MemAccount = "didi";
		MemPswd = "520";
		MemName = "臭弟弟";
		Sex = 1;
		
		dateString ="2015-05-20";
		sdf = new SimpleDateFormat("yyyy-MM-dd");
		uday = sdf.parse(dateString).getTime();
		Birthday = new Date(uday);
		
		Email = "didi@yahoo.com.tw";
		MlineId = "520didi";
		MemTel = "02-5201314";
		MemAddr = "淡水區";		
		
		imageFile = new File("WebContent/images/members/didi.jpg");
		fileName = imageFile.getName();
		is = new FileInputStream(imageFile);
		io = new ImagesIo();
		data = io.isToByte(is);				
		
		MemberService addM0 = new MemberService();
		addM0.update(MemId,MemAccount, MemPswd, MemName, Sex, Birthday, Email, MlineId, MemTel, MemAddr, data, fileName,0);
	
		
		MemId = 2;
		MemAccount = "snoopy";
		MemPswd = "123";
		MemName = "史小比";
		Sex = 1;		
				
		dateString ="1990-05-26";
		sdf = new SimpleDateFormat("yyyy-MM-dd");
		uday = sdf.parse(dateString).getTime();
		Birthday = new Date(uday);
		
		Email = "abc@yahoo.com.tw";
		MlineId = "abc123";
		MemTel = "02-0494582";
		MemAddr = "大安區";		
				
		imageFile = new File("WebContent/images/members/snoopy.jpg");
		fileName = imageFile.getName();	
		is = new FileInputStream(imageFile);
		io = new ImagesIo();
		data = io.isToByte(is);
		
		addM0.update(MemId,MemAccount, MemPswd, MemName, Sex, Birthday, Email, MlineId, MemTel, MemAddr, data, fileName,0);

		
		MemId = 3;
		MemAccount = "kitty";
		MemPswd = "456";
		MemName = "凱小蒂";
		Sex = 0;
		
		dateString ="1986-03-13";
		sdf = new SimpleDateFormat("yyyy-MM-dd");
		uday = sdf.parse(dateString).getTime();
		Birthday = new Date(uday);
		
		Email = "def@yahoo.com.tw";
		MlineId = "abc456";
		MemTel = "02-8825252";
		MemAddr = "中山區";		
		
		imageFile = new File("WebContent/images/members/kitty.jpg");
		fileName = imageFile.getName();
		is = new FileInputStream(imageFile);
		io = new ImagesIo();
		data = io.isToByte(is);			
		
		addM0.update(MemId,MemAccount, MemPswd, MemName, Sex, Birthday, Email, MlineId, MemTel, MemAddr, data, fileName,0);

		
		MemId = 4;
		MemAccount = "micky";
		MemPswd = "789";
		MemName = "米小奇";
		Sex = 1;
		
		dateString ="1992-07-01)";
		sdf = new SimpleDateFormat("yyyy-MM-dd");
		uday = sdf.parse(dateString).getTime();
		Birthday = new Date(uday);
		
		Email = "ghi@yahoo.com.tw";
		MlineId = "abc789";
		MemTel = "02-4532789";
		MemAddr = "信義區";
		
		imageFile = new File("WebContent/images/members/micky.jpg");
		fileName = imageFile.getName();
		is = new FileInputStream(imageFile);
		io = new ImagesIo();
		data = io.isToByte(is);				
		
		addM0.update(MemId,MemAccount, MemPswd, MemName, Sex, Birthday, Email, MlineId, MemTel, MemAddr, data, fileName,0);
/*
 * 		
 *			'||''|.                    .   |''||''|         '||      '||          
 *			 ||   ||    ....   ....  .||.     ||     ....    || ...   ||    ....  
 *			 ||''|'   .|...|| ||. '   ||      ||    '' .||   ||'  ||  ||  .|...|| 
 *			 ||   |.  ||      . '|..  ||      ||    .|' ||   ||    |  ||  ||      
 *			.||.  '|'  '|...' |'..|'  '|.'   .||.   '|..'|'  '|...'  .||.  '|...' 
 *
 *
 * *********************************************************************************/
		RestId = 1;
		ShopId = 1;
		RestName = "教父牛排";
		RestTel = "8501-1838";
		Restaddr = "台北市中山區樂群三路58號";
		Restbrief = "牛排教父開的店，喜愛牛排會朝聖一次環境優雅，根據喜愛不同的口感選擇牛排如果覺得晚餐價位高，可以考慮午餐時段喔食記參考：大庭小倍吃遊趣.凱棠的一咪咪小世界";
		Ein = 26325356;
		
		dateString ="13:00:00";
		sdf = new SimpleDateFormat("hh:mm:ss");
		uday = sdf.parse(dateString).getTime();
		RestStart = new Time(uday);
		
		dateString ="22:00:00";
		sdf = new SimpleDateFormat("hh:mm:ss");
		uday = sdf.parse(dateString).getTime();
		RestEnd = new Time(uday);
		
		RestRate = 80;
		RestNum = 30;		
		
		imageFile = new File("WebContent/images/rests/"+food[1]+"/beff01.jpg");
		fileName = imageFile.getName();
		is = new FileInputStream(imageFile);
		io = new ImagesIo();
		data = io.isToByte(is);				
		
		RestService addR1 = new RestService();
		addR1.update(RestId, ShopId, RestName, RestTel, Restaddr, Ein, RestStart, RestEnd, RestRate, RestNum, data, fileName, Restbrief,0,299);
				
		RestId = 2;
		ShopId = 2;
		RestName = "小惡魔牛排";
		RestTel = "2248-2766";
		Restaddr = "新北市中和區中和路246號";
		Restbrief = "約會首選聖地，來頭同樣不可小覷精緻的餐點與服務，牛肉完全攻佔大腦甜點與飲料可能比較不像牛排那樣讓人驚豔整體上還是很值得一試的餐廳";
		Ein = 24125632;
		
		dateString ="17:00:00";
		sdf = new SimpleDateFormat("hh:mm:ss");
		uday = sdf.parse(dateString).getTime();
		RestStart = new Time(uday);
		
		dateString ="23:00:00";
		sdf = new SimpleDateFormat("hh:mm:ss");
		uday = sdf.parse(dateString).getTime();
		RestEnd = new Time(uday);
		
		RestRate = 73;
		RestNum = 30;		
		
		imageFile = new File("WebContent/images/rests/"+food[2]+"/beff01.jpg");
		fileName = imageFile.getName();
		is = new FileInputStream(imageFile);
		io = new ImagesIo();
		data = io.isToByte(is);				
		
		addR1.update(RestId, ShopId, RestName, RestTel, Restaddr, Ein, RestStart, RestEnd, RestRate, RestNum, data, fileName, Restbrief,0,399);
				
		RestId = 3;
		ShopId = 3;
		RestName = "紅牛牛排";
		RestTel = "8941-8800";
		Restaddr = "新北市永和區安樂路168號";
		Restbrief = "很有特色與氣氛的一間店入口還能看到烤爐看到料理中的牛排讓人食慾大開每道餐點都具有一定水準選擇這間店也不失為好選擇";
		Ein = 12546856;
		
		dateString ="17:00:00";
		sdf = new SimpleDateFormat("hh:mm:ss");
		uday = sdf.parse(dateString).getTime();
		RestStart = new Time(uday);
		
		dateString ="23:00:00";
		sdf = new SimpleDateFormat("hh:mm:ss");
		uday = sdf.parse(dateString).getTime();
		RestEnd = new Time(uday);
		
		RestRate = 75;
		RestNum = 30;		
		
		imageFile = new File("WebContent/images/rests/"+food[3]+"/beff01.jpg");
		fileName = imageFile.getName();
		is = new FileInputStream(imageFile);
		io = new ImagesIo();
		data = io.isToByte(is);				
		
		addR1.update(RestId, ShopId, RestName, RestTel, Restaddr, Ein, RestStart, RestEnd, RestRate, RestNum, data, fileName, Restbrief,0,499);
		
		RestId = 4;
		ShopId = 1;
		RestName = "王品牛排";
		RestTel = " 2325-3478";
		Restaddr = "台北市大安區光復南路612號";
		Restbrief = "王品牛排-一頭牛，僅供6客王品牛排，新鮮蔬果醃浸2天2夜，250℃高溫烘烤1.5小時，完美呈現全熟牛排的香嫩風華。";
		Ein = 12546856;
		
		dateString ="11:00:00";
		sdf = new SimpleDateFormat("hh:mm:ss");
		uday = sdf.parse(dateString).getTime();
		RestStart = new Time(uday);
		
		dateString ="22:00:00";
		sdf = new SimpleDateFormat("hh:mm:ss");
		uday = sdf.parse(dateString).getTime();
		RestEnd = new Time(uday);
		
		RestRate = 83;
		RestNum = 30;		
		
		imageFile = new File("WebContent/images/rests/"+food[4]+"/beff01.jpg");
		fileName = imageFile.getName();
		is = new FileInputStream(imageFile);
		io = new ImagesIo();
		data = io.isToByte(is);				
		
		addR1.update(RestId, ShopId, RestName, RestTel, Restaddr, Ein, RestStart, RestEnd, RestRate, RestNum, data, fileName, Restbrief,0,599);
	
/*
 *			'||''|.                    .   '||''|.  '||                .           
 *			 ||   ||    ....   ....  .||.   ||   ||  || ..     ...   .||.    ...   
 *			 ||''|'   .|...|| ||. '   ||    ||...|'  ||' ||  .|  '|.  ||   .|  '|. 
 *			 ||   |.  ||      . '|..  ||    ||       ||  ||  ||   ||  ||   ||   || 
 *			.||.  '|'  '|...' |'..|'  '|.' .||.     .||. ||.  '|..|'  '|.'  '|..|' 
 *
 ***********************************************************************************/                                                                    
		                                                                       
		RestPhotoService rpsc1 = new RestPhotoService();
		ImagesIo io = new ImagesIo();
		for(int j=1;j<food.length;j++){
			byte[] RestImage1 = io.isToByte(new FileInputStream(new File("WebContent/images/rests/"+food[j]+"/beff02.jpg")));
			byte[] RestImage2 = io.isToByte(new FileInputStream(new File("WebContent/images/rests/"+food[j]+"/beff03.jpg")));
			byte[] RestImage3 = io.isToByte(new FileInputStream(new File("WebContent/images/rests/"+food[j]+"/beff04.jpg")));
			rpsc1.update(j,j,RestImage1, "beff01", RestImage2, "beff02", RestImage3, "beff03");
		}
	}
}

