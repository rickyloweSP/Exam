Recalculate_Next_Payment_Date_Scheduled batch2 = new Recalculate_Next_Payment_Date_Scheduled();
String sch2 = '0 0 1 * * ?';
system.schedule('Recalculate Next Payment Date', sch2, batch2);
