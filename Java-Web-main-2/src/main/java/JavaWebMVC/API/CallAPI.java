package JavaWebMVC.API;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class CallAPI {
	// Call API
	public static StringBuffer Get(String link) {
		try {
			URL url = new URL(link);
			HttpURLConnection http = (HttpURLConnection) url.openConnection();
			http.setRequestMethod("GET");

			BufferedReader in = new BufferedReader(
					new InputStreamReader(http.getInputStream(), StandardCharsets.UTF_8));
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			http.disconnect();

			System.out.println("response: "+response);
			return response;
		} catch (Exception e) {
			System.out.println("response Error: "+e);
		}
		return null;
	}

	public static StringBuffer post(String link, String data) {
		try {
			URL url = new URL(link);
			HttpURLConnection http = (HttpURLConnection) url.openConnection();
			http.setRequestMethod("POST");
			http.setDoOutput(true);
			http.setRequestProperty("Accept", "application/json");
			http.setRequestProperty("Content-Type", "application/json");

			byte[] out = data.getBytes(StandardCharsets.UTF_8);

			OutputStream stream = http.getOutputStream();
			stream.write(out);
			BufferedReader in = new BufferedReader(
					new InputStreamReader(http.getInputStream(), StandardCharsets.UTF_8));
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			http.disconnect();
			return response;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

	public static StringBuffer put(String link, String data) {
		try {
			URL url = new URL(link);
			HttpURLConnection http = (HttpURLConnection) url.openConnection();
			http.setRequestMethod("PUT");
			http.setDoOutput(true);
			http.setRequestProperty("Accept", "application/json");
			http.setRequestProperty("Content-Type", "application/json");

			byte[] out = data.getBytes(StandardCharsets.UTF_8);

			OutputStream stream = http.getOutputStream();
			stream.write(out);
			BufferedReader in = new BufferedReader(
					new InputStreamReader(http.getInputStream(), StandardCharsets.UTF_8));
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();			
			http.disconnect();
			return response;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

}
