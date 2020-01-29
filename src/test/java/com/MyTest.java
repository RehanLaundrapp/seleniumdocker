package com;

import com.tests.BaseTest;
import org.testng.annotations.Test;

/**
 * Created by Rehan on 29/01/2020.
 */
public class MyTest extends BaseTest {

    @Test
    public void testEnterGoogle() {
        driver.get("https://www.google.com");
        System.out.println(driver.getTitle());
    }

    @Test
    public void testEnterReddit() {
        driver.get("https://www.reddit.com");
        System.out.println(driver.getTitle());
    }

    @Test
    public void testEnterbbc() {
        driver.get("https://www.bbc.com");
        System.out.println(driver.getTitle());
    }

    @Test
    public void testEnterudemy() {
        driver.get("https://www.udemy.com");
        System.out.println(driver.getTitle());
    }

    @Test
    public void testEnterapple() {
        driver.get("https://www.apple.com");
        System.out.println(driver.getTitle());
    }


}
