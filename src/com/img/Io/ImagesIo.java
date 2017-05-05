package com.img.Io;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class ImagesIo {

	public byte[] isToByte(InputStream is) {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		int length = 0;
		byte buffer[] = new byte[512];
		try {
			while ((length = is.read(buffer)) != -1) {
				// 從緩衝區讀取buffer裡面0~length-1的位置
				baos.write(buffer, 0, length);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		byte[] data = baos.toByteArray();
		
		return data;

	}

}
