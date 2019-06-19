
package all;

import com.sun.jndi.toolkit.url.Uri;
import org.junit.After;
import org.junit.Before;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.openqa.selenium.remote.*;
import org.openqa.selenium.remote.DesiredCapabilities;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class Common {
    public WebDriver driver;
    public Map<String, Object> vars;
    JavascriptExecutor js;
    String remoteUrl = "http://localhost:6081/wd/hub";

    @Before
    public void setUp() throws MalformedURLException {

        //-------------Chrome-------------//

        //Local
/*        String driverPath = System.getProperty("user.dir") + "\\selenium\\src\\main\\resources\\static\\selenium\\drivers\\chromedriver.exe";
        System.out.println(driverPath);
        System.setProperty("webdriver.chrome.driver", driverPath);
        driver = new ChromeDriver();*/

        //Remote
/*        DesiredCapabilities chromeCapabilities = DesiredCapabilities.chrome();
        driver = new RemoteWebDriver(new URL(remoteUrl), chromeCapabilities);*/


        //-------------FireFox-------------//
        //Local
/*        String driverPath = System.getProperty("user.dir") + "\\selenium\\src\\main\\resources\\static\\selenium\\drivers\\geckodriver.exe";
        System.setProperty("webdriver.gecko.driver", driverPath);
        FirefoxOptions options = new FirefoxOptions();
        options.setCapability("marionette", false);
        driver = new FirefoxDriver(options);*/

        //Remote
        DesiredCapabilities capabilities = DesiredCapabilities.firefox();
        driver = new RemoteWebDriver(new URL(remoteUrl), capabilities);

        //All
        js = (JavascriptExecutor) driver;
        vars = new HashMap<>();
    }

    @After
    public void tearDown() {
        driver.quit();
    }

}

