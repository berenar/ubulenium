package formulari;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import java.util.HashMap;
import java.util.Map;

public class basicTest {
    private WebDriver driver;
    private Map<String, Object> vars;
    JavascriptExecutor js;

    @Before
    public void setUp() {
        driver = new ChromeDriver();
        //System.setProperty("webdriver.chrome.driver", "C:\\seleniumDrivers\\chromedriver.exe");
        js = (JavascriptExecutor) driver;
        vars = new HashMap<>();
    }

    @After
    public void tearDown() {
        driver.quit();
    }

    @Test
    public void aixoesunaprova() {
        driver.get("http://localhost:8080/index.html");
        driver.manage().window().setSize(new Dimension(1936, 1066));
        driver.findElement(By.id("name")).click();
        driver.findElement(By.id("name")).sendKeys("Hola");
        driver.findElement(By.id("mail")).sendKeys("aixoesunaprova@gmail");
        driver.findElement(By.id("msg")).click();
        driver.findElement(By.id("mail")).click();
        driver.findElement(By.id("mail")).sendKeys("aixoesunaprova@gmail.com");
        driver.findElement(By.id("msg")).click();
        driver.findElement(By.id("msg")).click();
        driver.findElement(By.id("msg")).sendKeys("drhsdthsd rthr thrth rth thgd ");
        driver.findElement(By.cssSelector("button")).click();
        driver.close();
    }
}
