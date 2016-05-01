import java.util.ArrayList;
import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.AfterReturning;


public aspect myAspect {
	private int calldepth;
	static ArrayList<relationValues> relations = new ArrayList<relationValues>();
	pointcut function():
		call(* *.*(..)) && within(*) && !within(myAspect) && !within(sequenceDiagram) && !within(demo);

	pointcut functionReturn():
		within(*) && call(* *.*(..))  && !within(myAspect) && !within(sequenceDiagram) && !within(demo);


	
	before():function(){
	/*	System.out.println("joinpoint" + thisJoinPoint);
		System.out.println("sourceclass:" +  thisJoinPoint.getThis().getClass().getName());
		System.out.println("targetclass:" + thisJoinPoint.getTarget().getClass().getName());
		System.out.println("signature" + thisJoinPoint.getSignature().getName());
		System.out.println("args:" + Arrays.deepToString(thisJoinPoint.getArgs()));
		Object[] values = thisJoinPoint.getArgs();
		for(int i=0; i < values.length; i++) {
			System.out.println(values[i].getClass().getName());
		}
		System.out.println("...aspect before");*/
		if(thisJoinPoint.getThis() != null && thisJoinPoint.getTarget()!= null) {
			String relation = thisJoinPoint.getThis().getClass().getName() + " -> " + thisJoinPoint.getTarget().getClass().getName()
					+ " : " + thisJoinPoint.getSignature().getName() + "(" + Arrays.deepToString(thisJoinPoint.getArgs()) + ")";
			//System.out.println("Relation:" +  relation);
			relations.add(new relationValues(relation, "entry"));
		}
	}

	after() returning(Object obj) : functionReturn() {
	/*	System.out.println("sourceclass:" +  thisJoinPoint.getThis().getClass().getName());
		System.out.println("targetclass:" + thisJoinPoint.getTarget().getClass().getName());
		System.out.println("signature" + thisJoinPoint.getSignature().getName());
		System.out.println("args:" + Arrays.deepToString(thisJoinPoint.getArgs()));
		System.out.println(".... aspect after");*/
		if(thisJoinPoint.getThis() != null && thisJoinPoint.getTarget()!= null) {
			exitRelation(thisJoinPoint.getThis().getClass().getName(), thisJoinPoint.getTarget().getClass().getName(), obj);
		}		
	}

	after() throwing(Throwable t) : functionReturn() {
		if(thisJoinPoint.getThis() != null && thisJoinPoint.getTarget()!= null) {
			String relation = thisJoinPoint.getThis().getClass().getName() + " -> " + thisJoinPoint.getTarget().getClass().getName()
					 + " : throws" + "(" + t + ")";
		    //System.out.println("Relation:" +  relation);
			relations.add(new relationValues(relation, "exception"));
		}		
	}
	
	
	private void exitRelation(String src, String des, Object... returnobj){
		String returnvalue = Arrays.deepToString(returnobj);
		if(returnvalue.equals("[null]")) {
			returnvalue = "";
		} else {
            returnvalue = " : return ( " + returnvalue + ")";
        }
		String relation = des + " --> " + src + returnvalue;
	    //System.out.println("relation:" + relation);
        if(!(des.equals(src) && returnvalue.equals(""))){
            relations.add(new relationValues(relation, "exit"));
        }
	}
	
	public static ArrayList<relationValues> getRelations(){
		return relations;
	}
}

class relationValues{
	String relation;
	String pointInfo;
	
	public relationValues(String relation, String pointInfo){
		this.relation = relation;
		this.pointInfo = pointInfo;
		
	}
}
