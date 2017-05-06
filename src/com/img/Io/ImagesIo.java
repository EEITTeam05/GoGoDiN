package com.img.Io;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class ImagesIo {

	public byte[] isToByte(InputStream is) throws IOException {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		int length = 0;
		byte buffer[] = new byte[512];
		byte[] data = null;
		try {
			while ((length = is.read(buffer)) != -1) {
				// 從緩衝區讀取buffer裡面0~length-1的位置
				baos.write(buffer, 0, length);
			}
			 data = baos.toByteArray();
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			is.close();
			baos.close();
		}
		return data;
	}

}
