package util;

import java.io.IOException;
import java.util.logging.FileHandler;
import java.util.logging.Formatter;
import java.util.logging.Level;
import java.util.logging.LogRecord;
import java.util.logging.Logger;

public class TestLogger {
    public static void logfun(String arg1,String arg2) throws IOException {
    		    		
    		String logname = "./logs/"+arg1+".log";
            
            Logger log = Logger.getLogger("lavasoft");
            log.setLevel(Level.INFO);
            Logger log1 = Logger.getLogger("lavasoft");
            System.out.println(log == log1);     //true
            //Logger log2 = Logger.getLogger("lavasoft.blog");
//            log2.setLevel(Level.WARNING);
            /*ConsoleHandler consoleHandler = new ConsoleHandler();
            consoleHandler.setLevel(Level.ALL);
            log.addHandler(consoleHandler);*/

            FileHandler fileHandler = new FileHandler(logname, 0, 1, true);
            fileHandler.setLevel(Level.INFO);
            fileHandler.setFormatter(new MyLogHander());
            
            log.addHandler(fileHandler);

            log.info(arg2);
            //log2.info("");
            //log2.fine("fine");
            fileHandler.close();
    }
}

class MyLogHander extends Formatter {
    @Override
    public String format(LogRecord record) {
            return record.getLevel() + ":" + record.getMessage()+"\n";
    }
} 



