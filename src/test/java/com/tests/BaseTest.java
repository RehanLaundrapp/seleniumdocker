package com.tests;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.testng.ITestContext;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;

import java.net.MalformedURLException;
import java.net.URL;

public class BaseTest {

    protected WebDriver driver;

    @BeforeTest
    public void setupDriver(ITestContext ctx) throws MalformedURLException {
        // BROWSER => chrome / firefox
        // HUB_HOST => localhost / 10.0.1.3 / hostname

        String host = "localhost";
        String myIP = "192.168.1.46";
        DesiredCapabilities dc;

        if(System.getProperty("BROWSER") != null &&
                System.getProperty("BROWSER").equalsIgnoreCase("firefox")){
            dc = DesiredCapabilities.firefox();
        }else{
            dc = DesiredCapabilities.chrome();
        }

        if(System.getProperty("HUB_HOST") != null){
            host = System.getProperty("HUB_HOST");
        }

        String testName = ctx.getCurrentXmlTest().getName();

        System.out.println("trying to hit GRID at IP: " + host);
        System.out.println("You have successfully compiled through docker");
        System.out.println("testing if compile command works");

        String completeUrl = "http://" + host + ":4444/wd/hub";
        dc.setCapability("name", testName);
        this.driver = new RemoteWebDriver(new URL(completeUrl), dc);
    }

    @AfterTest
    public void quitDriver(){
        this.driver.quit();
    }



}
