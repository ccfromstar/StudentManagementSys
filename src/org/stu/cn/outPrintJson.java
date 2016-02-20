package org.stu.cn;

import java.sql.Statement;

import org.json.*;

public class outPrintJson {
	
	public outPrintJson(){
		
	}
	
	public JSONObject StringToJson(String str) throws JSONException{
		JSONObject a = new JSONObject(str); 
		return a;
	}
}
