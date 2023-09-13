from selenium import webdriver
from selenium.webdriver.chrome.options import Options

options = Options()
options.binary_location = "/Applications/Caret\ Beta.app/Contents/MacOS/Electron"
driver = webdriver.Chrome(options=options)
print(driver.window_handles)
driver.close()