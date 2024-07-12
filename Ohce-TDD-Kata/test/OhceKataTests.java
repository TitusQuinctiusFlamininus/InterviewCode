
import org.junit.Before;
import org.junit.Test;

import static junit.framework.TestCase.assertEquals;

public class OhceKataTests {

    OHCETimeManager testSubject;
    TimeNow someTime;

    @Before
    public void setUp() {
        testSubject = new OHCETimeManager();
        someTime = new TimeNow();
    }

    // Before noon
    @Test
    public void startingOHCE_Morning_Produces_EarlyGreeting(){
        someTime.setTheTime("08:26:10.516851");
        assertEquals("Buenas días", testSubject.startOHCE(someTime));
    }

    @Test
    public void startingOHCE_BeforeNoon_Produces_EarlyGreeting(){
        someTime.setTheTime("11:26:10.516851");
        assertEquals("Buenas días", testSubject.startOHCE(someTime));
    }

    @Test
    public void startingOHCE_ExactlyHighNoon_Produces_EarlyGreeting(){
        someTime.setTheTime("12:00:00.000000");
        assertEquals("Buenas días", testSubject.startOHCE(someTime));
    }

    //Afternoon, before 8
    @Test
    public void startingOHCE_JustAfterHighNoon_MinutesAhead_Produces_AfternoonGreeting(){
        someTime.setTheTime("12:01:00.000000");
        assertEquals("Buenas tardes", testSubject.startOHCE(someTime));
    }

    @Test
    public void startingOHCE_JustAfterHighNoon_SecondsAhead_Produces_AfternoonGreeting(){
        someTime.setTheTime("12:00:01.000000");
        assertEquals("Buenas tardes", testSubject.startOHCE(someTime));
    }

    @Test
    public void startingOHCE_JustAfterHighNoon_MilliSecondsAhead_Produces_AfternoonGreeting(){
        someTime.setTheTime("12:00:00.462784");
        assertEquals("Buenas tardes", testSubject.startOHCE(someTime));
    }

    @Test
    public void startingOHCE_JustAfterNoon_Produces_AfternoonGreeting(){
        someTime.setTheTime("14:26:10.516851");
        assertEquals("Buenas tardes", testSubject.startOHCE(someTime));
    }

    @Test
    public void startingOHCE_AfterLateNoon_StillProduces_AnAfternoonGreeting(){
        someTime.setTheTime("16:30:10.516851");
        assertEquals("Buenas tardes", testSubject.startOHCE(someTime));
    }

    @Test
    public void startingOHCE_ExactlyAtEight_StillProduces_AnAfternoonGreeting(){
        someTime.setTheTime("20:00:00.000000");
        assertEquals("Buenas tardes", testSubject.startOHCE(someTime));
    }

    //Evening mode
    @Test
    public void startingOHCE_JustAfterEight_StillProduces_AnAEveningGreeting(){
        someTime.setTheTime("20:45:45.063000");
        assertEquals("Buenas noches", testSubject.startOHCE(someTime));
    }

    @Test
    public void startingOHCE_AfterEight_StillProduces_AnAEveningGreeting(){
        someTime.setTheTime("22:45:45.063000");
        assertEquals("Buenas noches", testSubject.startOHCE(someTime));
    }


}
