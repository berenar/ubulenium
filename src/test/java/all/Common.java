package all;

import org.junit.After;
import org.junit.Before;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import java.util.HashMap;
import java.util.Map;

public class Common {
    public WebDriver driver;
    public Map<String, Object> vars;
    JavascriptExecutor js;

    @Before
    public void setUp() {
        //Chrome
        String driverPath = System.getProperty("user.dir") + "\\seleniumDrivers\\chromedriver.exe";
        System.setProperty("webdriver.chrome.driver", driverPath);
        driver = new ChromeDriver();

        //FireFox
/*        String driverPath = System.getProperty("user.dir") + "\\seleniumDrivers\\geckodriver.exe";
        System.setProperty("webdriver.gecko.driver", driverPath);
        FirefoxOptions options = new FirefoxOptions();
        options.setCapability("marionette", false);
        driver = new FirefoxDriver(options);*/

        js = (JavascriptExecutor) driver;
        vars = new HashMap<>();
    }

    @After
    public void tearDown() {
        driver.quit();
    }

}
