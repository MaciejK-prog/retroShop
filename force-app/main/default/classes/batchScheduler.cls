global class batchScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {
        discountManagerBatch b = new discountManagerBatch(); 
       database.executebatch(b);
    
    }

    public static void scheduler() {

        batchScheduler timeOfProcess = new batchScheduler();

        batchScheduler p = new batchScheduler();
        String sch = '0 0 13 * * ?';
        system.schedule('One Time Pro', sch, p);

    }

 }

