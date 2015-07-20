package com.sdunicom.iphone.apns;

import javapns.back.PushNotificationManager;
import javapns.back.SSLConnectionHelper;
import javapns.data.Device;
import javapns.data.PayLoad;

public class MainSend {
	public static void main(String[] args) throws Exception {
		try {
			  String deviceToken = "4a18fc7c6d413dbbe63033c8d8d4ac7c7c988ba6328948181bc0c9fc307e5b16";

			  PayLoad payLoad = new PayLoad();
			  payLoad.addAlert("Œ“µƒpush≤‚ ‘_java");
			  payLoad.addBadge(4);
			  payLoad.addSound("default");
						
			  PushNotificationManager pushManager = PushNotificationManager.getInstance();
			  pushManager.addDevice("iPhone", deviceToken);
						
			  //Connect to APNs 
			  String host= "gateway.sandbox.push.apple.com";
			  int port = 2195;
			  String certificatePath= "/Users/chentao/Documents/work/javawork/puchChat_TInMan_2/xueche_push_development.p12";
			  String certificatePassword= "xueche";
			  pushManager.initializeConnection(host,port, certificatePath,certificatePassword, SSLConnectionHelper.KEYSTORE_TYPE_PKCS12);
						
			  //Send Push
			  Device client = pushManager.getDevice("iPhone");
			  pushManager.sendNotification(client, payLoad);
			  pushManager.stopConnection();

			  pushManager.removeDevice("iPhone");
			 }
			 catch (Exception e) {
			  e.printStackTrace();
		}
	}
}
