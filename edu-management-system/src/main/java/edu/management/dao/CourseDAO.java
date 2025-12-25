package edu.management.dao;

import edu.management.model.Course;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {

    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT * FROM courses ORDER BY course_code";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setCourseCode(rs.getString("course_code"));
                course.setCourseName(rs.getString("course_name"));
                course.setDescription(rs.getString("description"));
                course.setCredit(rs.getInt("credit"));
                course.setCapacity(rs.getInt("capacity"));
                course.setEnrolledCount(rs.getInt("enrolled_count"));
                course.setTeacherName(rs.getString("teacher_name"));
                course.setScheduleTime(rs.getString("schedule_time"));
                course.setClassroom(rs.getString("classroom"));
                course.setRequired(rs.getBoolean("is_required"));

                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courses;
    }

    public List<Course> getCoursesByStudentId(int studentId) {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, cs.status FROM courses c " +
                "LEFT JOIN course_selections cs ON c.id = cs.course_id AND cs.student_id = ? " +
                "ORDER BY c.course_code";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, studentId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course();
                    course.setId(rs.getInt("id"));
                    course.setCourseCode(rs.getString("course_code"));
                    course.setCourseName(rs.getString("course_name"));
                    course.setDescription(rs.getString("description"));
                    course.setCredit(rs.getInt("credit"));
                    course.setCapacity(rs.getInt("capacity"));
                    course.setEnrolledCount(rs.getInt("enrolled_count"));
                    course.setTeacherName(rs.getString("teacher_name"));
                    course.setScheduleTime(rs.getString("schedule_time"));
                    course.setClassroom(rs.getString("classroom"));
                    course.setRequired(rs.getBoolean("is_required"));

                    String status = rs.getString("status");
                    course.setSelected(status != null && status.equals("selected"));

                    courses.add(course);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courses;
    }

    public boolean selectCourse(int studentId, int courseId) {
        String checkSql = "SELECT * FROM course_selections WHERE student_id = ? AND course_id = ?";
        String insertSql = "INSERT INTO course_selections (student_id, course_id, status) VALUES (?, ?, 'selected')";
        String updateSql = "UPDATE course_selections SET status = 'selected' WHERE student_id = ? AND course_id = ?";
        String updateCountSql = "UPDATE courses SET enrolled_count = enrolled_count + 1 WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false);

            // 检查是否已存在记录
            boolean exists = false;
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, studentId);
                checkStmt.setInt(2, courseId);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    exists = rs.next();
                }
            }

            // 插入或更新选课记录
            try (PreparedStatement courseStmt = conn.prepareStatement(exists ? updateSql : insertSql)) {
                courseStmt.setInt(1, studentId);
                courseStmt.setInt(2, courseId);
                courseStmt.executeUpdate();
            }

            // 更新课程人数
            try (PreparedStatement updateStmt = conn.prepareStatement(updateCountSql)) {
                updateStmt.setInt(1, courseId);
                updateStmt.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean dropCourse(int studentId, int courseId) {
        String sql = "UPDATE course_selections SET status = 'dropped' WHERE student_id = ? AND course_id = ?";
        String updateCountSql = "UPDATE courses SET enrolled_count = enrolled_count - 1 WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, studentId);
                pstmt.setInt(2, courseId);
                pstmt.executeUpdate();
            }

            try (PreparedStatement updateStmt = conn.prepareStatement(updateCountSql)) {
                updateStmt.setInt(1, courseId);
                updateStmt.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Course> getSelectedCourses(int studentId) {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.* FROM courses c " +
                "JOIN course_selections cs ON c.id = cs.course_id " +
                "WHERE cs.student_id = ? AND cs.status = 'selected' " +
                "ORDER BY c.course_code";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, studentId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course();
                    course.setId(rs.getInt("id"));
                    course.setCourseCode(rs.getString("course_code"));
                    course.setCourseName(rs.getString("course_name"));
                    course.setDescription(rs.getString("description"));
                    course.setCredit(rs.getInt("credit"));
                    course.setCapacity(rs.getInt("capacity"));
                    course.setEnrolledCount(rs.getInt("enrolled_count"));
                    course.setTeacherName(rs.getString("teacher_name"));
                    course.setScheduleTime(rs.getString("schedule_time"));
                    course.setClassroom(rs.getString("classroom"));
                    course.setRequired(rs.getBoolean("is_required"));
                    course.setSelected(true);

                    courses.add(course);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courses;
    }
}