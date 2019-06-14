/*
package all;

import org.openqa.selenium.Dimension;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class record {
    static WebDriver driver;
    static Map<String, Object> vars;
    static JavascriptExecutor js;

    public static void main(String[] args) throws MalformedURLException, InterruptedException {
        DesiredCapabilities chromeCapabilities = DesiredCapabilities.chrome();
        driver = new RemoteWebDriver(new URL("http://localhost:4444/wd/hub"), chromeCapabilities);
        js = (JavascriptExecutor) driver;
        vars = new HashMap<>();

        driver.get("http://192.168.212.16:8080/es/reservar");
        driver.manage().window().setSize(new Dimension(1653, 1050));

        Thread.sleep(1000*60*5);
        System.out.println(driver.getTitle());
    }


}

*/
