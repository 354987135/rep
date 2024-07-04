#include <iostream>
#include <iomanip>
#include <string>
#include <vector>
#include <array>
#include <map>
#include <numeric>
#include <algorithm>
#include <fstream>

enum class Exam {
    GESP1,
    GESP2,
    GESP3,
    GESP4,
    CSPJ,
    CSPS
};

enum class QuestionType {
    Select,
    Judge
};

int main() {
    std::ofstream fout("res.txt");

    std::map<Exam, std::map<QuestionType, std::vector<char>>> ANS;
    ANS[Exam::GESP2] = 
    {
        {
            QuestionType::Select,
            {
                'D', 'C', 'A', 'D', 'B', 
                'A', 'C', 'C', 'B', 'B', 
                'A', 'D', 'C', 'D', 'C'
            }
        },
        {
            Question::Judge,
            {
                'F', 'F', 'T', 'F', 'F', 
                'F', 'F', 'T', 'T', 'T'
            }
        }
    };
    ANS[Exam::GESP3] = 
    {
        {
            Question::Select,
            {
                'B', 'B', 'C', 'B', 'A', 
                'A', 'B', 'C', 'C', 'A', 
                'B', 'D', 'B', 'D', 'B'
            }
        },
        {
            Question::Judge,
            {
                'F', 'T', 'F', 'F', 'T', 
                'F', 'F', 'F', 'T', 'T'
            }
        }
    };

    struct Student {
        std::string name;
        std::map<Question, std::vector<char>> ans;
        std::vector<int> score;
        Exam exam;
        std::vector<std::vector<std::pair<int, char>>> wrong {2};
    };

    std::vector<Student> students {
        {
            "XXX", 
            {
                Question::Select,
                {
                    'D', 'C', 'A', 'D', 'B',
                    'A', 'C', 'C', 'B', 'B',
                    'A', 'D', 'C', 'B', 'C'
                },
                Question::Judge,
                {
                    'F', 'T', 'T', 'F', 'F',
                    'F', 'F', 'T', 'T', 'T'
                }
            },  
            {0, 0, 25, 20, 0},
            2
        }
    };

    fout << std::left << std::setw(11) << "姓名";
    fout << std::left << std::setw(14) << "选择题";
    fout << std::left << std::setw(14) << "判断题";
    fout << std::left << std::setw(14) << "编程题1";
    fout << std::left << std::setw(15) << "编程题2";
    fout << std::left << std::setw(12) << "总分";
    fout << std::left << std::setw(13) << "评测等级";
    fout << '\n';

    for (auto &stu : students) {
        for (int i = 0; i < stu.ans[0].size(); ++i) {
            if (stu.ans[0][i] == ANS[stu.level][0][i]) {
                stu.score[0] += 2;
            } else {
                stu.wrong[0].push_back({i + 1, stu.ans[0][i]});
            }
        }
        for (int i = 0; i < stu.ans[1].size(); ++i) {
            if (stu.ans[1][i] == ANS[stu.level][1][i]) {
                stu.score[1] += 2;
            } else {
                stu.wrong[1].push_back({i + 1, stu.ans[1][i]});
            }
        }
        stu.score[4] = std::accumulate(stu.score.begin(), stu.score.end() - 1, 0);
    }
    std::sort(students.begin(), students.end(), [](Student &stu1, Student &stu2) {
        if (stu1.level < stu2.level) {
            return true;
        }
        if (stu1.level > stu2.level) {
            return false;
        }
        return stu1.score[4] > stu2.score[4];
    });

    for (auto &stu : students) {
        fout << std::left << std::setw(14) << stu.name;
        for (int i = 0; i < 5; ++i) {
            fout << std::left << std::setw(10) << stu.score[i];
        }
        fout << std::left << std::setw(14) << std::to_string(stu.level) + " 级";
        fout << '\n';
    }

    fout << "\n\n";

    for (auto &stu : students) {
        fout << stu.name << "\n";
        fout << "选择题错题及错误选项: ";
        for (int i = 0; i < stu.wrong[0].size(); ++i) {
            fout << stu.wrong[0][i].first << '.' << stu.wrong[0][i].second << "  ";
        }
        fout << '\n';
        fout << "判断题错题及错误选项: ";
        for (int i = 0; i < stu.wrong[1].size(); ++i) {
            fout << stu.wrong[1][i].first << '.' << stu.wrong[1][i].second << "  ";
        }
        fout << "\n\n";
    }
}