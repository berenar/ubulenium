package all;

import org.junit.After;
import org.junit.Before;
import org.openqa.selenium.Capabilities;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.UnexpectedAlertBehaviour;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class Common {
    public WebDriver driver;
    public Map<String, Object> vars;
    JavascriptExecutor js;

    @Before
    public void setUp() throws MalformedURLException {
        //Chrome

/*      //Local
        String driverPath = System.getProperty("user.dir") + "\\seleniumDrivers\\chromedriver.exe";
        System.setProperty("webdriver.chrome.driver", driverPath);
        driver = new ChromeDriver();*/

        //Remote
        Capabilities chromeCapabilities = DesiredCapabilities.chrome();
        driver = new RemoteWebDriver(new URL("http://localhost:4444/wd/hub"), chromeCapabilities);

        //FireFox
        /*
        //Local
        String driverPath = System.getProperty("user.dir") + "\\seleniumDrivers\\geckodriver.exe";
        System.setProperty("webdriver.gecko.driver", driverPath);
        FirefoxOptions options = new FirefoxOptions();
        options.setCapability("marionette", false);
        driver = new FirefoxDriver(options);*/

        js = (JavascriptExecutor) driver;
        vars = new HashMap<>();
    }

    @After
    public void tearDown() {
        //driver.quit();
    }

}
