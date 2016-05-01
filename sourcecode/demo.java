import org.junit.runner.JUnitCore;
import org.junit.runner.Result;



public class demo {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String path = args[0] + "/" + args[2];
	    String classname = args[1] ;
        try {
            Class c = Class.forName(classname);
            JUnitCore junit = new JUnitCore();
            Result result = junit.run(c);
                //new ObserverTest().test1();
            new sequenceDiagram().createDiagram(myAspect.getRelations(), path);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}

}
