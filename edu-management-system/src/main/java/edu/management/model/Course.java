package edu.management.model;

public class Course {
    private int id;
    private String courseCode;
    private String courseName;
    private String description;
    private int credit;
    private int capacity;
    private int enrolledCount;
    private String teacherName;
    private String scheduleTime;
    private String classroom;
    private boolean isRequired;
    private boolean isSelected; // 当前用户是否已选

    // 构造方法
    public Course() {}

    // Getter和Setter方法
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public int getEnrolledCount() {
        return enrolledCount;
    }

    public void setEnrolledCount(int enrolledCount) {
        this.enrolledCount = enrolledCount;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getScheduleTime() {
        return scheduleTime;
    }

    public void setScheduleTime(String scheduleTime) {
        this.scheduleTime = scheduleTime;
    }

    public String getClassroom() {
        return classroom;
    }

    public void setClassroom(String classroom) {
        this.classroom = classroom;
    }

    public boolean isRequired() {
        return isRequired;
    }

    public void setRequired(boolean required) {
        isRequired = required;
    }

    public boolean isSelected() {
        return isSelected;
    }

    public void setSelected(boolean selected) {
        isSelected = selected;
    }
}