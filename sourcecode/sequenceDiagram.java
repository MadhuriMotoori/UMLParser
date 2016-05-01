
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;


import net.sourceforge.plantuml.SourceStringReader;


public class sequenceDiagram {
	
	public void createDiagram(ArrayList<relationValues> relations,String path) {
        try {
            final OutputStream png = new FileOutputStream(path + ".png");
            String result = "@startuml\n";
            for (relationValues relationInfo : relations) {
            	//System.out.println("RelationInfo:" +  relationInfo.relation);
            	if(!relationInfo.relation.contains("java.")) {
            		result += relationInfo.relation + "\n";
            	}            
}

            result += "@enduml\n";

            System.out.println(result);
            SourceStringReader reader = new SourceStringReader(result);
            reader.generateImage(png);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
