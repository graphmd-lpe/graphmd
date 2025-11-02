# Restore from Backup

Restore git repositories from public backups using `restore-from-backup-mirror.sh`.

## Prerequisites

- `git`
- `curl` (pre-installed on most systems)
- Public HTTPS URL to the backup bundle

## Usage

```bash
# Restore to specified directory
./restore-from-backup-mirror.sh https://mirror.git.artbin.me/graphmd-lpe/graphmd.bundle /path/to/restore

# Restore to current directory
./restore-from-backup-mirror.sh https://mirror.git.artbin.me/graphmd-lpe/graphmd.bundle
```

## How It Works

1. Downloads the bundle via HTTPS using `curl`
2. Verifies bundle integrity using `git bundle verify`
3. Clones repository from bundle
4. Cleans up temporary files

## Common Workflows

### Inspect Before Full Restore

```bash
# Restore to temp directory
./restore-from-backup-mirror.sh https://mirror.git.artbin.me/graphmd-lpe/graphmd.bundle /tmp/inspect

# Check contents
cd /tmp/inspect
git log --oneline -10
git branch -a

# Clean up
rm -rf /tmp/inspect
```

### Restore Specific Branch

```bash
# Restore full repository
./restore-from-backup-mirror.sh https://mirror.git.artbin.me/graphmd-lpe/graphmd.bundle ~/project

# Checkout desired branch
cd ~/project
git checkout feature-branch
```

## Notes

- Only works with publicly accessible HTTPS URLs
- Bundle files must have `.bundle` extension (or will be added automatically)
- The script validates that URLs use HTTPS protocol
