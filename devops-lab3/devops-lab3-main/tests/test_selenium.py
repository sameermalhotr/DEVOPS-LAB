from selenium import webdriver
from selenium.webdriver.chrome.options import Options

options = Options()
options.add_argument("--headless=new")
options.add_argument("--no-sandbox")

driver = webdriver.Remote(
    command_executor="http://localhost:4444",
    options=options
)

try:
    driver.get("http://host.docker.internal:5002/")
    text = driver.find_element("tag name", "body").text

    assert "DevOps Lab 3" in text
    assert "NEW FEATURE ENABLED" in text

    print("PASS: Homepage loaded successfully")
    print("PASS: Feature flag enabled")
    print("PASS: Selenium browser automation completed")

finally:
    driver.quit()
