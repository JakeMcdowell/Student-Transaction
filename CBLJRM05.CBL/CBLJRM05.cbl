       IDENTIFICATION DIVISION.
       PROGRAM-ID.                 CBLJRM05.
       AUTHOR.                     JAKE MCDOWELL.
       DATE-WRITTEN.               10/12/2023
       DATE-COMPILED.

      *******************************************************************
      *                           MCDOWELL                              *
      *                                                                 *
      *                  READ IN THE TRAN-STU-FILE AND                  *
      *          UPDATE BOTH THE STUDENT-FILE AND COURSE-FILE           *
      *                THEN PRINTING OUT TO STDNTCRS.PRT                *
      *                                                                 *
      *******************************************************************

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.

       FILE-CONTROL.
           SELECT STUDENT-FILE
               ASSIGN TO "C:\COBOL LL\STUDMAST.DAT"
               ORGANIZATION IS INDEXED
               ACCESS IS RANDOM
               RECORD KEY IS STUDENT-ID
               FILE STATUS IS RESPONSE-CODE.

           SELECT COURSE-FILE
               ASSIGN TO "C:\COBOL LL\STCOURSE.DAT"
               ORGANIZATION IS INDEXED
               ACCESS IS DYNAMIC
               RECORD KEY IS C-KEY
               FILE STATUS IS RESPONSE-CODE.
           
           SELECT TRAN-STU-FILE
               ASSIGN TO 'C:\COBOL LL\STCRTRAN.DAT'
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT COURSE-PRTOUT
               ASSIGN TO "C:\COBOL\STDNTCRS.PRT"
               ORGANIZATION IS RECORD SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
        
       FD  STUDENT-FILE
           LABEL RECORD IS STANDARD
           RECORD CONTAINS 53 CHARACTERS
           DATA RECORD IS STUDENT-MAST.
       COPY 'CBLSTUD.CPY'.

       FD  COURSE-FILE
           LABEL RECORD IS STANDARD
           RECORD CONTAINS 54 CHARACTERS
           DATA RECORD IS COURSE-MAST.
       COPY 'CBLCRSE.CPY'.
      
       FD  TRAN-STU-FILE
           LABEL RECORDS ARE STANDARD
           RECORD CONTAINS 95 CHARACTERS
           DATA RECORD IS TRAN-REC.

       01 TRAN-REC.
           05 KEY-OUT.
               10  TRAN-STUD-ID            PIC X(6).
               10  TRAN-COURSE-ID          PIC X(8).
           05  TRAN-COURSE-NAME        PIC X(30).
           05  TRAN-COURSE-CREDITS     PIC 9.
           05  TRAN-COURSE-GPA         PIC 9V99.
           05  TRAN-TERM               PIC XX.
           05  TRAN-YEAR               PIC 9(4).
           05  TRAN-LNAME              PIC X(20).
           05  TRAN-FNAME              PIC X(20).
           05  TRAN-INIT               PIC X.


        FD COURSE-PRTOUT
           LABEL RECORD IS OMITTED
           DATA RECORD IS PRTLINE
           RECORD CONTAINS 132 CHARACTERS
           LINAGE IS 60 WITH FOOTING AT 56.

       01  PRTLINE                PIC X(132).
       
       WORKING-STORAGE SECTION.

       01  WORK-AREA.
           05      C-PCTR           PIC 99       VALUE ZERO.
           05      C-SCTR           PIC 999      VALUE ZERO.
           05  MORE-RECS            PIC XXX      VALUE ZERO.
           05  COURSE-MORE-RECS     PIC XXX      VALUE ZERO.
           05  H-COURSE-BREAK. 
               10  H-STUDENT-ID     PIC X(6).
               10  H-COURSE-ID      PIC X(8).
           05  C-TOT-CRED-EARN      PIC 99V99     VALUE ZERO.
           05  C-TOT-COURSE-CREDITS PIC 99        VALUE ZERO.
           05  C-TOT-COURSE-GPA     PIC 99V99     VALUE ZERO.
           05  C-TOT-STU-GPAB       PIC 9V99      VALUE ZERO.
           05  C-STUDENT-TOTAL      PIC 99        VALUE ZERO.
       
       01  CURRENT-DATE-AND-TIME.
           05      I-DATE.
                   10  I-YEAR     PIC 9(4).
                   10  I-MONTH    PIC 99.
                   10  I-DAY      PIC 99.

       01 RESPONSE-CODE             PIC XX.
           88  VAL-CODE             VALUE '00'.
           88  NFND-CODE            VALUE '23'.

       01 SOMETHING                 PIC XXX.

       01 TITLE-LINE.
           05      FILLER          PIC X(6)      VALUE "DATE: ".
           05      O-MONTH         PIC 99.
           05      FILLER          PIC X         VALUE '/'.
           05      O-DAY           PIC 99.
           05      FILLER          PIC X         VALUE '/'.
           05      O-YEAR          PIC 9(4).
           05      FILLER          PIC X(36)     VALUE SPACES.
           05      FILLER          PIC X(28)     VALUE "MCDOWELL".
           05      FILLER          PIC X(44)     VALUE SPACES.
           05      FILLER          PIC X(6)      VALUE "PAGE:".
           05      O-PCTR          PIC Z9.

       01 STUDENT-INFO-HDG.
           05 FILLER             PIC X(10)     VALUES "STUDENT ID".
           05 FILLER             PIC X(16)     VALUES SPACES.
           05 FILLER             PIC X(12)     VALUES "STUDENT NAME".
           05 FILLER             PIC X(20)     VALUES SPACES.
           05 FILLER             PIC X(9)      VALUES "COURSE ID".
           05 FILLER             PIC X(16)     VALUES SPACES.
           05 FILLER             PIC X(11)     VALUES "COURSE NAME".
           05 FILLER             PIC X(12)     VALUES SPACES.
           05 FILLER             PIC X(7)      VALUES "CREDITS".
           05 FILLER             PIC X(3)     VALUES SPACES.
           05 FILLER             PIC X(3)      VALUES "GPA".
           05 FILLER             PIC X(4)     VALUES SPACES.
           05 FILLER             PIC X(9)      VALUES "COMPLETED".




       
       01 STUDENT-INFO-LINE.
           05 O-STUDENT-ID      PIC X(8).
           05 FILLER            PIC X(5)    VALUES SPACES.
           05 O-STUDENT-NAME    PIC X(40). 
           05 FILLER            PIC X(6)     VALUES SPACES.
           05 O-COURSE-ID       PIC X(10).
           05 FILLER            PIC X(6)     VALUES SPACES.
           05 O-COURSE-NAME     PIC X(30). 
           05 FILLER            PIC X(5)     VALUES SPACES.
           05 O-COURSE-CREDITS  PIC 9. 
           05 FILLER            PIC X(6)     VALUES SPACES.
           05 O-COURSE-GPA      PIC 9V99. 
           05 FILLER            PIC X(4)    VALUES SPACES.
           05 O-COURSE-TERM-COMPLETE  PIC X(7).
           05 FILLER            PIC X(1)    VALUES SPACES.


           
           
           

       01 STUDENT-SUBTOTAL-LINE.
           05 FILLER             PIC X(2)      VALUES SPACES.
           05 FILLER             PIC X(10)     VALUES "STUDENT ID".
           05 FILLER             PIC X(2)      VALUES SPACES.
           05 O-STUDENT-IDB      PIC 9(6).
           05 FILLER             PIC X(3)      VALUES SPACES.
           05 FILLER             PIC X(12)     VALUES "STUDENT NAME".
           05 FILLER             PIC X(2)      VALUES SPACES.
           05 O-STUDENT-NAMEB    PIC X(41). 
           05 FILLER             PIC X(3)      VALUES SPACES.
           05 FILLER             PIC X(20)     VALUES
                                               "TOTAL CREDITS EARNED".
           05 FILLER             PIC X(2)      VALUES SPACES.
           05 O-TOT-CRED-EARN    PIC 99V99.
           05 FILLER             PIC X(3)     VALUES SPACES.
           05 FILLER             PIC X(17)      VALUES
                                                   "TOTAL STUDENT GPA".
           05 FILLER             PIC X(2)      VALUES SPACES.
           05 O-TOT-STU-GPAB     PIC 999.
              
       01 STUDENT-TOTAL.
           05 FILLER           PIC X(95)       VALUES SPACES.
           05 FILLER           PIC X(15)       VALUES "STUDENT TOTAL: ".
           05 FILLER           PIC X(3)       VALUES SPACES.
           05 STUDENT-COUNT    PIC 999.
           05 FILLER           PIC X(16)       VALUES SPACES.


       PROCEDURE DIVISION.

       0000-MAIN.
           PERFORM 1000-INIT.
           PERFORM 2000-MAINLINE
               UNTIL MORE-RECS = "NO".
           PERFORM 3000-INIT-REPORT.
           PERFORM 4000-MAINLINE-REPORT
               UNTIL COURSE-MORE-RECS = "NO".
           PERFORM 5000-CLOSING.
           STOP RUN.

       1000-INIT.
           MOVE FUNCTION CURRENT-DATE TO CURRENT-DATE-AND-TIME.
           MOVE I-YEAR TO O-YEAR.
           MOVE I-MONTH TO O-MONTH.
           MOVE I-DAY TO O-DAY.

           OPEN INPUT TRAN-STU-FILE.
           OPEN I-O STUDENT-FILE.
           OPEN I-O COURSE-FILE.
           OPEN OUTPUT COURSE-PRTOUT.
           PERFORM 9000-TRAN-READ.
          
       2000-MAINLINE.
           PERFORM 9100-STUDENT-READ.
           IF VAL-CODE 
               PERFORM 2100-UPDATE-STUDENT
           
               IF VAL-CODE
                   PERFORM 93000-COURSE-READ
                   EVALUATE RESPONSE-CODE
                       WHEN '23'
                           PERFORM 2200-ADD-COURSE
                       WHEN '00'
                           IF TRAN-YEAR = 0
                               PERFORM 2300-DELETE-COURSE-REC
                           ELSE
                               PERFORM 2400-UPDATE-COURSE-REC
                        WHEN OTHER
                            PERFORM 9200-ERROR-MES.
           PERFORM 9000-TRAN-READ.

          


           
       2100-UPDATE-STUDENT.
         
           PERFORM 2110-STUDENT-INFO.
               READ STUDENT-FILE
                   INVALID KEY
                       PERFORM 9200-ERROR-MES
                   NOT INVALID KEY
                       PERFORM 2110-STUDENT-INFO.

       2110-STUDENT-INFO.

           MOVE TRAN-LNAME TO STUDNET-LNAME
           MOVE TRAN-FNAME TO STUDENT-FNAME
           MOVE TRAN-INIT TO STUDENT-INIT
           MOVE TRAN-TERM TO STUDENT-TERM-LAST-ATT
           MOVE TRAN-YEAR TO STUDENT-YEAR-LAST-ATT
           REWRITE STUDENT-MAST
                       INVALID KEY
                           PERFORM 9200-ERROR-MES.

       2200-ADD-COURSE.

           PERFORM 9400-COURSE-INFO.
               WRITE COURSE-MAST
                   INVALID KEY
                       PERFORM 9200-ERROR-MES.

      

       2300-DELETE-COURSE-REC.

           DELETE COURSE-FILE
                INVALID KEY
                   PERFORM 9200-ERROR-MES.

       2400-UPDATE-COURSE-REC.
           PERFORM 9400-COURSE-INFO.

       3000-INIT-REPORT.
           MOVE LOW-VALUES TO C-KEY.
           START COURSE-FILE
               KEY > C-KEY
                   INVALID KEY
                       PERFORM 9200-ERROR-MES
                   NOT INVALID KEY
                       PERFORM 9500-COURSE-READ.
           MOVE C-KEY TO H-COURSE-BREAK.
       4000-MAINLINE-REPORT.
           IF H-COURSE-BREAK NOT = C-KEY
               PERFORM 5100-MAJOR-BREAK.
           PERFORM 4100-CALCS.
           PERFORM 4200-OUTPUT.

       4100-CALCS.

           ADD C-COURSE-CREDITS TO C-TOT-CRED-EARN.
           ADD C-COURSE-CREDITS TO C-TOT-COURSE-CREDITS.
           ADD C-COURSE-GPA TO C-TOT-COURSE-GPA.
           COMPUTE C-TOT-STU-GPAB = 
                       C-TOT-COURSE-CREDITS * C-TOT-COURSE-GPA.

       4200-OUTPUT.
           ADD 1 TO C-STUDENT-TOTAL.
           MOVE STUDENT-ID TO C-STUDENT-ID.
           PERFORM 9100-STUDENT-READ.

           STRING STUDENT-ID-1 DELIMITED BY SPACES
             '-' STUDENT-ID-2 DELIMITED BY SPACES
             '-' STUDENT-ID-3 DELIMITED BY SPACES
                   INTO O-STUDENT-ID.


           STRING STUDNET-LNAME DELIMITED BY SPACES
                  ', ' STUDENT-FNAME DELIMITED BY SPACES
                  ' ' DELIMITED BY SIZE
                  STUDENT-INIT DELIMITED BY SIZE
                       INTO O-STUDENT-NAME.

           STRING COURSE-ID-1 DELIMITED BY SPACES
                  ' ' DELIMITED BY SIZE
             COURSE-ID-2 DELIMITED BY SPACES
                  ' ' DELIMITED BY SIZE
             COURSE-ID-3 DELIMITED BY SPACES
                   INTO O-COURSE-ID.

           MOVE C-COURSE-NAME TO O-COURSE-NAME.     
           MOVE C-COURSE-CREDITS TO O-COURSE-CREDITS. 
           MOVE C-COURSE-GPA TO O-COURSE-GPA.

           STRING C-TERM-COMPLETED DELIMITED BY SPACES
             '/' C-YEAR-COMPLETED DELIMITED BY SPACES
                      INTO O-COURSE-TERM-COMPLETE. 


           WRITE PRTLINE FROM STUDENT-INFO-LINE
               AFTER ADVANCING 2 LINES
           WRITE PRTLINE FROM STUDENT-INFO-LINE
               AFTER ADVANCING 2 LINES
                   AT EOP
                       PERFORM 9600-HDG.

       5000-CLOSING.
           MOVE C-SCTR TO O-PCTR.
           PERFORM 5100-MAJOR-BREAK.
           WRITE PRTLINE FROM STUDENT-SUBTOTAL-LINE
               AFTER ADVANCING 2 LINES.
           
           PERFORM 5200-STUDENT-TOTAL.
           CLOSE TRAN-STU-FILE.
           CLOSE STUDENT-FILE.
           CLOSE COURSE-FILE.
           CLOSE COURSE-PRTOUT.
           

       5100-MAJOR-BREAK.
           STRING STUDENT-ID-1 DELIMITED BY SPACES
             '-' STUDENT-ID-2 DELIMITED BY SPACES
             '-' STUDENT-ID-3 DELIMITED BY SPACES
                   INTO O-STUDENT-IDB.


           STRING STUDNET-LNAME DELIMITED BY SPACES
                  ', ' STUDENT-FNAME DELIMITED BY SPACES
                  ' ' DELIMITED BY SIZE
                  STUDENT-INIT DELIMITED BY SIZE
                       INTO O-STUDENT-NAMEB.
           MOVE C-TOT-CRED-EARN TO O-TOT-CRED-EARN
           MOVE C-TOT-STU-GPAB TO O-TOT-STU-GPAB.

           COMPUTE C-TOT-CRED-EARN = 0.
           COMPUTE C-TOT-STU-GPAB = 0.
           MOVE C-KEY TO H-COURSE-BREAK.


       5200-STUDENT-TOTAL.
           MOVE C-STUDENT-TOTAL TO STUDENT-COUNT.
           WRITE PRTLINE FROM STUDENT-TOTAL
                   AFTER ADVANCING 3 LINE.

       9000-TRAN-READ.
            READ TRAN-STU-FILE
               AT END
                   MOVE "NO" TO MORE-RECS.
      
       9100-STUDENT-READ.    
           MOVE TRAN-STUD-ID TO STUDENT-ID
           READ STUDENT-FILE.

               

       9200-ERROR-MES.

           IF NFND-CODE
               DISPLAY 'STUDENT ID IS NOT FOUND ', TRAN-STUD-ID

               ACCEPT SOMETHING
           ELSE
               DISPLAY 'UNDETERMINED ERROR. STUDENT = ' TRAN-STUD-ID
      -                               ', RETURN CODE IS ' RESPONSE-CODE.

       93000-COURSE-READ.

           MOVE KEY-OUT TO C-KEY
           READ COURSE-FILE
               INVALID KEY
                   PERFORM 9200-ERROR-MES.


       9400-COURSE-INFO.

           MOVE TRAN-COURSE-ID TO C-COURSE-ID
           MOVE TRAN-COURSE-NAME TO C-COURSE-NAME
           MOVE TRAN-COURSE-CREDITS TO C-COURSE-CREDITS
           MOVE TRAN-COURSE-GPA TO C-COURSE-GPA
           REWRITE COURSE-MAST
               INVALID KEY
                   PERFORM 9200-ERROR-MES.

       9500-COURSE-READ.
            READ COURSE-FILE NEXT RECORD
               AT END
                   MOVE "NO" TO MORE-RECS.

       9600-HDG.
           ADD 1 TO C-PCTR.
           MOVE C-PCTR TO O-PCTR.
           WRITE PRTLINE FROM TITLE-LINE
               AFTER ADVANCING PAGE.
           WRITE PRTLINE FROM STUDENT-INFO-HDG
               AFTER ADVANCING 2 LINES.
