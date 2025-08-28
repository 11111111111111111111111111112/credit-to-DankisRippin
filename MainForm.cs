using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DankBDOLauncher
{
    public partial class MainForm : Form
    {
        private readonly Dictionary<string, string> actionDescriptions = new()
        {
            { "DankLauncher", "Complete system optimization and game launch" },
            { "Networkoptimizer", "Advanced network optimization" },
            { "dismsfc", "System maintenance and integrity check" },
            { "restartservices", "Restart essential Windows services" },
            { "Dankmouboard", "Mouse and keyboard optimization" },
            { "clientbdoandsteamlauncherin1", "Registry Optimizations" }
        };

        private readonly Dictionary<string, Color> actionColors = new()
        {
            { "DankLauncher", Color.FromArgb(255, 107, 107) },
            { "Networkoptimizer", Color.FromArgb(78, 205, 196) },
            { "dismsfc", Color.FromArgb(255, 167, 38) },
            { "restartservices", Color.FromArgb(78, 205, 196) },
            { "Dankmouboard", Color.FromArgb(255, 107, 107) },
            { "clientbdoandsteamlauncherin1", Color.FromArgb(78, 205, 196) }
        };

        public MainForm()
        {
            InitializeCustomComponents();
            SetupEventHandlers();
        }

        private void InitializeCustomComponents()
        {
            // Set form properties
            this.Text = "Dank BDO Launcher - Ultimate Optimization Suite";
            this.Size = new Size(1200, 800);
            this.StartPosition = FormStartPosition.CenterScreen;
            this.FormBorderStyle = FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.BackColor = Color.FromArgb(15, 15, 35);

            // Create main panel
            var mainPanel = new Panel
            {
                Dock = DockStyle.Fill,
                BackColor = Color.FromArgb(15, 15, 35),
                AutoScroll = true
            };

            // Create header
            var headerPanel = CreateHeaderPanel();
            mainPanel.Controls.Add(headerPanel);

            // Create main content
            var contentPanel = CreateContentPanel();
            mainPanel.Controls.Add(contentPanel);

            // Create footer
            var footerPanel = CreateFooterPanel();
            mainPanel.Controls.Add(footerPanel);

            this.Controls.Add(mainPanel);
        }

        private Panel CreateHeaderPanel()
        {
            var panel = new Panel
            {
                Dock = DockStyle.Top,
                Height = 150,
                BackColor = Color.Transparent
            };

            var titleLabel = new Label
            {
                Text = "DANK BDO LAUNCHER",
                Font = new Font("Segoe UI", 36, FontStyle.Bold),
                ForeColor = Color.White,
                TextAlign = ContentAlignment.MiddleCenter,
                Dock = DockStyle.Top,
                Height = 80
            };

            var subtitleLabel = new Label
            {
                Text = "Ultimate Black Desert Online Optimization Suite",
                Font = new Font("Segoe UI", 14),
                ForeColor = Color.FromArgb(160, 160, 160),
                TextAlign = ContentAlignment.MiddleCenter,
                Dock = DockStyle.Top,
                Height = 30
            };

            var bannerLabel = new Label
            {
                Text = "🎮 Remember to smoke weed and PvP every day 🎮",
                Font = new Font("Segoe UI", 12, FontStyle.Bold),
                ForeColor = Color.White,
                TextAlign = ContentAlignment.MiddleCenter,
                Dock = DockStyle.Top,
                Height = 40,
                BackColor = Color.FromArgb(255, 107, 107)
            };

            panel.Controls.Add(bannerLabel);
            panel.Controls.Add(subtitleLabel);
            panel.Controls.Add(titleLabel);

            return panel;
        }

        private Panel CreateContentPanel()
        {
            var panel = new Panel
            {
                Dock = DockStyle.Fill,
                BackColor = Color.Transparent,
                Padding = new Padding(20, 120, 20, 10) // gui spacing
            };

            var tableLayout = new TableLayoutPanel
            {
                Dock = DockStyle.Fill,
                ColumnCount = 3,
                RowCount = 2,
                AutoScroll = true,
                ColumnStyles =
                {
                    new ColumnStyle(SizeType.Percent, 33.33f),
                    new ColumnStyle(SizeType.Percent, 33.33f),
                    new ColumnStyle(SizeType.Percent, 33.33f)
                },
                RowStyles =
                {
                    new RowStyle(SizeType.Percent, 50f),
                    new RowStyle(SizeType.Percent, 50f)
                },
                CellBorderStyle = TableLayoutPanelCellBorderStyle.None,
                Padding = new Padding(10)
            };

            // Create action cards
            int index = 0;
            foreach (var action in actionDescriptions)
            {
                var card = CreateActionCard(action.Key, action.Value, actionColors[action.Key]);
                
                int row = index / 3;
                int col = index % 3;
                tableLayout.Controls.Add(card, col, row);
                index++;
            }

            panel.Controls.Add(tableLayout);
            return panel;
        }

        private Panel CreateActionCard(string action, string description, Color accentColor)
        {
            var card = new Panel
            {
                Width = 350,
                Height = 200,
                Margin = new Padding(10),
                BackColor = Color.FromArgb(30, 30, 50),
                BorderStyle = BorderStyle.None
            };

            // Add rounded corners effect
            card.Paint += (s, e) =>
            {
                var path = new GraphicsPath();
                path.AddArc(0, 0, 20, 20, 180, 90);
                path.AddArc(card.Width - 20, 0, 20, 20, 270, 90);
                path.AddArc(card.Width - 20, card.Height - 20, 20, 20, 0, 90);
                path.AddArc(0, card.Height - 20, 20, 20, 90, 90);
                path.CloseFigure();

                card.Region = new Region(path);
            };

            // Action title
            var titleLabel = new Label
            {
                Text = GetActionDisplayName(action),
                Font = new Font("Segoe UI", 16, FontStyle.Bold),
                ForeColor = accentColor,
                Location = new Point(20, 20),
                Size = new Size(300, 30)
            };

            // Description
            var descLabel = new Label
            {
                Text = description,
                Font = new Font("Segoe UI", 10),
                ForeColor = Color.FromArgb(176, 176, 176),
                Location = new Point(20, 60),
                Size = new Size(300, 40),
                TextAlign = ContentAlignment.TopLeft
            };

            // Execute button
            var executeButton = new Button
            {
                Text = $"Execute {GetActionDisplayName(action)}",
                Font = new Font("Segoe UI", 10, FontStyle.Bold),
                ForeColor = Color.White,
                BackColor = accentColor,
                FlatStyle = FlatStyle.Flat,
                Location = new Point(20, 120),
                Size = new Size(150, 35),
                Cursor = Cursors.Hand
            };

            executeButton.FlatAppearance.BorderSize = 0;
            executeButton.Click += (s, e) => ExecuteAction(action);

            // Status label
            var statusLabel = new Label
            {
                Text = "Ready",
                Font = new Font("Segoe UI", 9),
                ForeColor = Color.FromArgb(100, 100, 100),
                Location = new Point(20, 160),
                Size = new Size(300, 20),
                TextAlign = ContentAlignment.MiddleLeft
            };

            // Progress bar
            var progressBar = new ProgressBar
            {
                Location = new Point(180, 120),
                Size = new Size(140, 35),
                Style = ProgressBarStyle.Continuous,
                Visible = false
            };

            card.Controls.Add(titleLabel);
            card.Controls.Add(descLabel);
            card.Controls.Add(executeButton);
            card.Controls.Add(statusLabel);
            card.Controls.Add(progressBar);

            // Store references for later use
            card.Tag = new { Action = action, StatusLabel = statusLabel, ProgressBar = progressBar, Button = executeButton };

            return card;
        }

        private Panel CreateFooterPanel()
        {
            var panel = new Panel
            {
                Dock = DockStyle.Bottom,
                Height = 80,
                BackColor = Color.Transparent
            };

            var footerLabel = new Label
            {
                Text = "Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn",
                Font = new Font("Segoe UI", 12, FontStyle.Bold),
                ForeColor = Color.FromArgb(128, 128, 128),
                TextAlign = ContentAlignment.MiddleCenter,
                Dock = DockStyle.Top,
                Height = 40
            };

            var creditLabel = new Label
            {
                Text = "Dank Tools - Credit to DankisRippin",
                Font = new Font("Segoe UI", 10),
                ForeColor = Color.FromArgb(96, 96, 96),
                TextAlign = ContentAlignment.MiddleCenter,
                Dock = DockStyle.Top,
                Height = 30
            };

            panel.Controls.Add(creditLabel);
            panel.Controls.Add(footerLabel);

            return panel;
        }

        private string GetActionDisplayName(string action)
        {
            return action switch
            {
                "DankLauncher" => "Dank Launcher",
                "Networkoptimizer" => "Network Optimizer",
                "dismsfc" => "System Corruption Checker",
                "restartservices" => "Service Manager",
                "Dankmouboard" => "Input Latency Optimization",
                "clientbdoandsteamlauncherin1" => "Registry Optimizations",
                _ => action
            };
        }

        private void SetupEventHandlers()
        {
            // Add keyboard shortcuts
            this.KeyPreview = true;
            this.KeyDown += (s, e) =>
            {
                if (e.Control)
                {
                    switch (e.KeyCode)
                    {
                        case Keys.D1:
                            e.Handled = true;
                            ExecuteAction("DankLauncher");
                            break;
                        case Keys.D2:
                            e.Handled = true;
                            ExecuteAction("Networkoptimizer");
                            break;
                        case Keys.D3:
                            e.Handled = true;
                            ExecuteAction("dismsfc");
                            break;
                        case Keys.D4:
                            e.Handled = true;
                            ExecuteAction("restartservices");
                            break;
                    }
                }
            };
        }

        private async void ExecuteAction(string action)
        {
            var card = FindCardByAction(action);
            if (card == null) return;

            var cardInfo = (dynamic)card.Tag;
            var statusLabel = (Label)cardInfo.StatusLabel;
            var progressBar = (ProgressBar)cardInfo.ProgressBar;
            var button = (Button)cardInfo.Button;

            try
            {
                // Disable button and show progress
                button.Enabled = false;
                progressBar.Visible = true;
                progressBar.Value = 0;
                statusLabel.Text = $"Starting {GetActionDisplayName(action)}...";
                statusLabel.ForeColor = Color.FromArgb(33, 150, 243);

                // Simulate progress
                var progressTimer = new System.Windows.Forms.Timer();
                progressTimer.Interval = 100;
                progressTimer.Tick += (s, e) =>
                {
                    if (progressBar.Value < 90)
                        progressBar.Value += 10;
                };
                progressTimer.Start();

                // Execute the action
                var result = await Task.Run(() => ExecuteBatchFile(action));

                // Complete progress
                progressBar.Value = 100;
                progressTimer.Stop();

                // Show success
                statusLabel.Text = $"{GetActionDisplayName(action)} completed successfully!";
                statusLabel.ForeColor = Color.FromArgb(76, 175, 80);

                // Hide progress bar after delay
                await Task.Delay(2000);
                progressBar.Visible = false;
                progressBar.Value = 0;

                // Reset status after delay
                await Task.Delay(3000);
                statusLabel.Text = "Ready";
                statusLabel.ForeColor = Color.FromArgb(100, 100, 100);
            }
            catch (Exception ex)
            {
                // Show error
                statusLabel.Text = $"Error: {ex.Message}";
                statusLabel.ForeColor = Color.FromArgb(244, 67, 54);
                progressBar.Visible = false;
                progressBar.Value = 0;
            }
            finally
            {
                button.Enabled = true;
            }
        }

        private string ExecuteBatchFile(string action)
        {
            // Map actions to their actual batch file names
            var batchFileName = action switch
            {
                "DankLauncher" => "DankLauncher.bat",
                "Networkoptimizer" => "Networkoptimizer.bat",
                "dismsfc" => "dismsfc.bat",
                "restartservices" => "restartservices.bat",
                "Dankmouboard" => "Dankmouboard.bat",
                "clientbdoandsteamlauncherin1" => "reg.bat",
                _ => $"{action}.bat"
            };

            var batchFile = Path.Combine(Application.StartupPath, batchFileName);
            
            if (!File.Exists(batchFile))
            {
                throw new FileNotFoundException($"Batch file not found: {batchFile}");
            }

            // Simple execution with admin prompt
            var process = new Process();
            process.StartInfo.FileName = "cmd.exe";
            process.StartInfo.Arguments = "/C \"" + batchFile + "\"";
            process.StartInfo.UseShellExecute = true;
            process.StartInfo.Verb = "runas";
            process.StartInfo.WorkingDirectory = Application.StartupPath;

            try
            {
                process.Start();
                return "Command started";
            }
            catch (Exception ex)
            {
                return $"Error: {ex.Message}";
            }
        }

        private Panel? FindCardByAction(string action)
        {
            foreach (Control control in this.Controls)
            {
                if (control is Panel mainPanel)
                {
                    foreach (Control subControl in mainPanel.Controls)
                    {
                        if (subControl is Panel contentPanel)
                        {
                            foreach (Control contentControl in contentPanel.Controls)
                            {
                                if (contentControl is TableLayoutPanel tableLayout)
                                {
                                    foreach (Control card in tableLayout.Controls)
                                    {
                                        if (card is Panel && card.Tag != null)
                                        {
                                            var cardInfo = (dynamic)card.Tag;
                                            if (cardInfo.Action == action)
                                                return (Panel)card;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return null;
        }
    }
} 