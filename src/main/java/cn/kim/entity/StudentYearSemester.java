package cn.kim.entity;

/**
 * Created by 余庚鑫 on 2018/8/15
 */
public class StudentYearSemester {
    /**
     * 学年
     */
    private String year;
    /**
     * 学期
     */
    private String semesterStr;
    /**
     * 学期
     */
    private int semester;

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getSemesterStr() {
        return semesterStr;
    }

    public void setSemesterStr(String semesterStr) {
        this.semesterStr = semesterStr;
    }

    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }

    @Override
    public String toString() {
        return "StudentYearSemester{" +
                "year='" + year + '\'' +
                ", semesterStr='" + semesterStr + '\'' +
                ", semester=" + semester +
                '}';
    }
}
