package edu.management.dao;

import edu.management.model.Schedule;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ScheduleDAO {

    public List<Schedule> getStudentSchedule(int studentId) {
        List<Schedule> schedules = new ArrayList<>();
        String sql = "SELECT s.*, c.course_name, c.classroom, c.teacher_name " +
                "FROM schedules s " +
                "JOIN courses c ON s.course_id = c.id " +
                "WHERE c.id IN (SELECT course_id FROM course_selections WHERE student_id = ? AND status = 'selected') " +
                "OR c.is_required = true " +
                "ORDER BY FIELD(s.day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'), s.start_time";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, studentId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Schedule schedule = new Schedule();
                    schedule.setId(rs.getInt("id"));
                    schedule.setCourseId(rs.getInt("course_id"));
                    schedule.setCourseName(rs.getString("course_name"));
                    schedule.setDayOfWeek(rs.getString("day_of_week"));
                    schedule.setStartTime(rs.getString("start_time"));
                    schedule.setEndTime(rs.getString("end_time"));
                    schedule.setClassroom(rs.getString("classroom"));
                    schedule.setTeacherName(rs.getString("teacher_name"));

                    schedules.add(schedule);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return schedules;
    }

    public List<Schedule> getAllSchedules() {
        List<Schedule> schedules = new ArrayList<>();
        String sql = "SELECT s.*, c.course_name, c.classroom, c.teacher_name FROM schedules s " +
                "JOIN courses c ON s.course_id = c.id " +
                "ORDER BY FIELD(s.day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'), s.start_time";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setId(rs.getInt("id"));
                schedule.setCourseId(rs.getInt("course_id"));
                schedule.setCourseName(rs.getString("course_name"));
                schedule.setDayOfWeek(rs.getString("day_of_week"));
                schedule.setStartTime(rs.getString("start_time"));
                schedule.setEndTime(rs.getString("end_time"));
                schedule.setClassroom(rs.getString("classroom"));
                schedule.setTeacherName(rs.getString("teacher_name"));

                schedules.add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return schedules;
    }
}