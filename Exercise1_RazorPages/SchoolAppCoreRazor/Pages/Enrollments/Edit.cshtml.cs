using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using SchoolAppCoreRazor.Models;

namespace SchoolAppCoreRazor.Pages.Enrollments
{
    public class EditModel : PageModel
    {
        private readonly SchoolAppCoreRazor.Models.SchoolContext _context;

        public EditModel(SchoolAppCoreRazor.Models.SchoolContext context)
        {
            _context = context;
        }

        [BindProperty]
        public Enrollment Enrollment { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var enrollment =  await _context.Enrollments.FirstOrDefaultAsync(m => m.EnrollmentID == id);
            if (enrollment == null)
            {
                return NotFound();
            }
            Enrollment = enrollment;

            ViewData["CourseID"] = new SelectList(
                _context.Courses.Select(c => new
                {
                    c.CourseID,
                    DisplayText = c.CourseID + " - " + c.Title
                }),
                "CourseID",
                "DisplayText",
                enrollment.CourseID
            );

            ViewData["StudentID"] = new SelectList(
                _context.Students.Select(s => new
                {
                    s.StudentID,
                    DisplayText = s.StudentID + " - " + s.FirstName + " " + s.LastName
                }),
                "StudentID",
                "DisplayText",
                enrollment.StudentID
            );

            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                ViewData["CourseID"] = new SelectList(
                    _context.Courses.Select(c => new
                    {
                        c.CourseID,
                        DisplayText = c.CourseID + " - " + c.Title
                    }),
                    "CourseID",
                    "DisplayText",
                    Enrollment?.CourseID
                );

                ViewData["StudentID"] = new SelectList(
                    _context.Students.Select(s => new
                    {
                        s.StudentID,
                        DisplayText = s.StudentID + " - " + s.FirstName + " " + s.LastName
                    }),
                    "StudentID",
                    "DisplayText",
                    Enrollment?.StudentID
                );

                return Page();
            }

            _context.Attach(Enrollment).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!EnrollmentExists(Enrollment.EnrollmentID))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return RedirectToPage("./Index");
        }

        private bool EnrollmentExists(int id)
        {
            return _context.Enrollments.Any(e => e.EnrollmentID == id);
        }
    }
}

